import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  List articles = [];
  final String apiKey = '476ecca18ef147cba6280bf5041c57f3';

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  fetchNews() async {
    final response = await http.get(
      Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'),
    );
    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body);
        articles = data['articles'];
      });
    } else {
      setState(() {
        articles = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Feed'),backgroundColor: Colors.brown,foregroundColor: Colors.white),
      body: articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'] ?? 'No Title',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    article['description'] ?? 'No Description',
                    style: TextStyle(fontSize: 14),
                  ),
                  if (article['urlToImage'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(article['urlToImage']),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
