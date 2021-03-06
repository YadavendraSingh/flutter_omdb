import 'movie.dart';

class SearchResult {
  String totalResults;
  List<Movie> movies;
  String result;

  SearchResult({
    this.totalResults,
    this.movies,
    this.result,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => new SearchResult(
        totalResults: json["totalResults"],
        movies:
            new List<Movie>.from(json["Search"].map((x) => Movie.fromJson(x))),
        result: json["Result"],
      );
}
