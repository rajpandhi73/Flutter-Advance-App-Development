import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _loading = true;
  String? _data;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _loading = false;
      _data = "Data loaded successfully!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loading Animation"), backgroundColor: Colors.deepOrange, foregroundColor: Colors.white,),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Text(_data!, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
