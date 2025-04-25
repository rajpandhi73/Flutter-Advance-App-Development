import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageGalleryScreen extends StatefulWidget {
  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  List<String> imageUrls = [];
  bool _isLoading = false;

  Future<void> uploadImage() async {
    setState(() => _isLoading = true);
    final picker = ImagePicker();

    try {
      final picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        File file = File(picked.path);
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final ref = FirebaseStorage.instance.ref().child('uploads/$fileName');

        print("Uploading file to: uploads/$fileName");

        // Upload the file and wait for completion
        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot snapshot = await uploadTask;

        // Check if upload was successful
        if (snapshot.state == TaskState.success) {
          final url = await snapshot.ref.getDownloadURL();
          print("Upload success! URL: $url");

          setState(() => imageUrls.add(url));

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload Successful')),
          );
        } else {
          throw Exception('Upload failed. TaskState: ${snapshot.state}');
        }
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print('Upload failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload Failed: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void showImagePreview(String url) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Gallery')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          ElevatedButton(
            onPressed: uploadImage,
            child: Text('Upload Image'),
          ),
          Expanded(
            child: imageUrls.isEmpty
                ? Center(child: Text('No images uploaded yet.'))
                : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: imageUrls.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => showImagePreview(imageUrls[i]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[i],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
