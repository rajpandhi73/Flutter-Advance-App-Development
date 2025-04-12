import 'package:flutter/material.dart';

class AnimatedButtonScreen extends StatefulWidget {
  const AnimatedButtonScreen({super.key});

  @override
  State<AnimatedButtonScreen> createState() => _AnimatedButtonScreenState();
}

class _AnimatedButtonScreenState extends State<AnimatedButtonScreen> {
  bool _pressed = false;

  void _toggle() => setState(() => _pressed = !_pressed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated Button"), backgroundColor: Colors.deepOrange,foregroundColor: Colors.white,),
      body: Center(
        child: GestureDetector(
          onTap: _toggle,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _pressed ? 200 : 100,
            height: _pressed ? 60 : 40,
            decoration: BoxDecoration(
              color: _pressed ? Colors.green : Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              'Tap Me',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
