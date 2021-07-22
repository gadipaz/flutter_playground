import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_playground/movie.dart';
import 'package:flutter_playground/results_page.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatelessWidget {
  var name = 'marvel';
  var limit = '25';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies Search'),
        ),
        body: SingleChildScrollView(
            child: Form(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.all(10),
                  child: Image(
                    image: AssetImage('images/popcorn.jpg'),
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(children: <Widget>[
                  Column(children: <Widget>[
                    TextFormField(
                      onChanged: (value) => name = value,
                      decoration: InputDecoration(labelText: 'Movie name'),
                    ),
                    TextFormField(
                      onChanged: (value) => limit = value,
                      decoration: InputDecoration(labelText: 'Num of movies'),
                    ),
                  ]),
                  Container(
                      margin: EdgeInsetsDirectional.only(top: 15),
                      child: ElevatedButton(
                        child: const Text('Search'),
                        onPressed: () async {
                          var response = await http.get(Uri.parse('https://itunes.apple.com/search?term=' + name + '&limit=' + limit));
                          if (response.statusCode == 200) {
                            // If the server did return a 200 OK response,
                            // then parse the JSON.
                            var moviesJson = jsonDecode(response.body)['results'];
                            List<Movie> movies = List<Movie>.from(moviesJson.map((i) => Movie.fromJson(i)).toList());
                            movies = movies.where((movie) => (movie.title?.isNotEmpty ?? false) && (movie.description?.isNotEmpty ?? false) && (movie.imageUrl?.isNotEmpty ?? false)).toList();

                            //Delay for 2 sec to feel like a long time process
                            await Future.delayed(Duration(seconds: 2));

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResultsPage(movies: movies)),
                            );
                          } else {
                            // If the server did not return a 200 OK response,
                            // then throw an exception.
                            throw Exception('Failed to search movies');
                          }
                        },
                      )),
                ]),
              ],
            ),
          ),
        )));
  }
}
