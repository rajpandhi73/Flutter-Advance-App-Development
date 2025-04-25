import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ChatScreen.dart';
import 'FirebaseAuthScreen.dart';
import 'ImageGalleryScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Projects',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Feature Hub')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FirebaseAuthScreen(),
                ));
              },
              child: Text('Firebase Auth - Sign Up/Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ));
              },
              child: Text('Firestore Chat App'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ImageGalleryScreen(),
                ));
              },
              child: Text('Firebase Storage Image Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
