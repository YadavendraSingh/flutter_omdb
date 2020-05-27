
class Movie {
  final String title;
  final String year;
  final String imdbRating;
  final String imdbID;
  final String poster;

  Movie({this.title, this.year, this.imdbRating, this.imdbID, this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['Title'],
        year: json['Year'],
        poster: json['Poster'],
        imdbRating: json['imdbRating'],
        imdbID: json['imdbID']);
  }
}
