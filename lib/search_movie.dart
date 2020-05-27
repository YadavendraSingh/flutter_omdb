import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search_result.dart';

class SearchMovie extends StatefulWidget {
  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _searchController = new TextEditingController();
  List<Movie> movieList = new List();
  static bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Search Movie"),
        actions: <Widget>[
          Container(
            width: 200,
            child: new TextField(
              controller: _searchController,
              style: new TextStyle(
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search, color: Colors.white),
                  hintText: "Search",
                  hintStyle: new TextStyle(color: Colors.white)),
              onChanged: (val) => debounce(
                  const Duration(milliseconds: 1500), searchOperation, [val]),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.count(
                crossAxisCount: 2,
                children: List.generate(movieList.length, (index) {
                  return Center(
                    child: MovieCard(
                      movie: movieList[index],
                    ),
                  );
                }),
              ),
      ),
    );
  }

  void searchOperation(String searchText) {
    if (searchText.trim().length > 2) {
      setState(() {
        _isLoading = true;
      });
      fetchMovie(searchText.trim());
    }
  }

  showSnackBar(String msg) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }

  fetchMovie(String searchText) async {
    final response = await http.get('http://www.omdbapi.com/?s=' +
        searchText +
        '&page=1&type=movie&apikey=848e1f7a');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        SearchResult result = SearchResult.fromJson(json.decode(response.body));
        if (result.movies.length > 0) {
          setState(() {
            movieList = result.movies;
            _isLoading = false;
          });
        } else {
          showError();
        }
      } on Exception catch (exception) {
        showError();
      } catch (error) {
        showError();
      }
    } else {
      // If the server did not return a 200 OK response,
      showError();
    }
  }

  showError() {
    setState(() {
      _isLoading = false;
    });
    FocusScope.of(context).requestFocus(new FocusNode());
    showSnackBar('No result found');
    movieList.clear();
  }

  // This map will track all your pending function calls
  Map<Function, Timer> _timeouts = {};

  void debounce(Duration timeout, Function target,
      [List arguments = const []]) {
    if (_timeouts.containsKey(target)) {
      _timeouts[target].cancel();
    }

    Timer timer = Timer(timeout, () {
      Function.apply(target, arguments);
    });

    _timeouts[target] = timer;
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({Key key, this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                movie.poster,
              ),
            ),
            Center(
              child: Text(
                movie.title,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 10),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  movie.year,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 10),
                ),
                Text(
                  movie.imdbID,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 10),
                ),
              ],
            ),
          ]),
    );
  }
}
