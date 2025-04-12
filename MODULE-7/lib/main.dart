import 'package:flutter/material.dart';
import 'package:module_7/splash_screen.dart';
import 'MovieSearchScreen.dart';
import 'NewsFeedScreen.dart';
import 'WeatherScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),backgroundColor: Colors.brown,foregroundColor: Colors.white,
      ),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherScreen()),
                );
              },
              child: Text('Weather App'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsFeedScreen()),
                );
              },
              child: Text('News Feed App'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieSearchScreen()),
                );
              },
              child: Text('Movie Search App'),
            ),
          ],
        ),
      ),
    );
  }
}