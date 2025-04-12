import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = '';
  String weatherData = '';
  final String apiKey = 'b76f3085a1ea245c5e4c26e9777e5574';

  void fetchWeather() async {
    if (city.isNotEmpty) {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
        ),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          weatherData =
          'City: ${data['name']}\nTemperature: ${data['main']['temp']}°C\nWeather: ${data['weather'][0]['description']}';
        });
      } else {
        setState(() {
          weatherData = 'City not found or error fetching data';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App'),backgroundColor: Colors.brown,foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                city = value;
              },
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            Text(
              weatherData,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
