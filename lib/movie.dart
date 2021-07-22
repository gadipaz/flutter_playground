class Movie {
  final String? title;
  final String? description;
  final String? imageUrl;

  Movie({required this.title, required this.description, required this.imageUrl});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['trackName'],
      description: json['longDescription'],
      imageUrl: json['artworkUrl100'],
    );
  }
}
