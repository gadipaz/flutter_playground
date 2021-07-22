import 'package:flutter/material.dart';
import 'package:flutter_playground/movie.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              movies[index].title!,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              movies[index].description!,
            ),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 44,
                maxHeight: 44,
              ),
              child: Image.network(movies[index].imageUrl!, fit: BoxFit.cover),
            ),
            onTap: () async {
              await showDialog(context: context, builder: (_) => ImageDialog(movies[index].imageUrl!));
            },
          );
        },
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  ImageDialog(this.selectedMovieImageUrl);

  final String selectedMovieImageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(selectedMovieImageUrl), fit: BoxFit.cover)),
      ),
    );
  }
}
