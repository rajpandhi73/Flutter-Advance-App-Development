import 'package:flutter/material.dart';

class HeroAnimationScreen extends StatelessWidget {
  const HeroAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero Animation - First'), backgroundColor: Colors.deepOrange, foregroundColor: Colors.white,),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => HeroSecondScreen()));
          },
          child: Hero(
            tag: 'hero-image',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/sample.jpg', width: 150),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroSecondScreen extends StatelessWidget {
  const HeroSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero Animation - Second'), backgroundColor: Colors.deepOrange,foregroundColor: Colors.white,),
      body: Center(
        child: Hero(
          tag: 'hero-image',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/sample.jpg', width: 300),
          ),
        ),
      ),
    );
  }
}
