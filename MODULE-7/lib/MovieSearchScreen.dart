import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieSearchScreen extends StatefulWidget {
  @override
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  String movieTitle = '';
  Map<String, dynamic>? movieData;
  bool isLoading = false;
  String errorMessage = '';
  final String apiKey = '295ea5a9';
  List<String> searchHistory = [];

  void searchMovie({String? customTitle}) async {
    final titleToSearch = customTitle ?? movieTitle;
    if (titleToSearch.isNotEmpty) {
      setState(() {
        isLoading = true;
        errorMessage = '';
        movieData = null;
      });

      final response = await http.get(
        Uri.parse('http://www.omdbapi.com/?t=$titleToSearch&apikey=$apiKey'),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['Response'] == 'True') {
          setState(() {
            movieData = data;
            if (!searchHistory.contains(titleToSearch)) {
              searchHistory.insert(0, titleToSearch);
            }
          });
        } else {
          setState(() {
            errorMessage = 'Movie not found';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load movie data';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                movieTitle = value;
              },
              decoration: InputDecoration(
                labelText: 'Enter movie title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => searchMovie(),
              child: Text('Search Movie'),
            ),
            if (searchHistory.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                'Search History:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ...searchHistory.map((title) => ListTile(
                title: Text(title),
                trailing: Icon(Icons.refresh),
                onTap: () => searchMovie(customTitle: title),
              )),
            ],
            if (isLoading) ...[
              SizedBox(height: 20),
              Center(child: CircularProgressIndicator()),
            ],
            if (errorMessage.isNotEmpty) ...[
              SizedBox(height: 20),
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
            if (movieData != null) ...[
              SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (movieData!['Poster'] != 'N/A')
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              movieData!['Poster'],
                              height: 300,
                            ),
                          ),
                        ),
                      SizedBox(height: 12),
                      Text(
                        'Title: ${movieData!['Title']}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('Year: ${movieData!['Year']}'),
                      Text('Genre: ${movieData!['Genre']}'),
                      Text('Director: ${movieData!['Director']}'),
                      Text('IMDB Rating: ${movieData!['imdbRating']}'),
                      SizedBox(height: 10),
                      Text('Plot:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(movieData!['Plot']),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
