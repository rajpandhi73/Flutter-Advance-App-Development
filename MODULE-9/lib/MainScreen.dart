import 'package:flutter/material.dart';
import 'AnimatedButtonScreen.dart';
import 'HeroAnimationScreen.dart';
import 'LoadingScreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Screen'), backgroundColor: Colors.deepOrange, foregroundColor: Colors.white,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AnimatedButtonScreen()));
              },
              child: Text("1. Animated Button"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => HeroAnimationScreen()));
              },
              child: Text("2. Hero Animation"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LoadingScreen()));
              },
              child: Text("3. Loading Animation"),
            ),
          ],
        ),
      ),
    );
  }
}
