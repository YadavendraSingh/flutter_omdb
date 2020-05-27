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
      appBar: AppBar(title: Text("Search Movie"), actions: <Widget>[
        Container(
          width: 200,
          child: new TextField(
            controller: _searchController,
            style: new TextStyle(
              color: Colors.white,
            ),
            decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search, color: Colors.white),
                hintText: "Search...",
                hintStyle: new TextStyle(color: Colors.white)),
            onChanged: searchOperation,
          ),
        ),
      ],
      ),
      body: Container(
        child:_isLoading?Center(child: CircularProgressIndicator()):
        GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(movieList.length, (index) {
            return Center(
              child: MovieCard(movie: movieList[index],),
            );
          }),
        ),
      ),
    );
  }

  void searchOperation(String searchText) {
    //searchresult.clear();
    if(searchText.length>2){

      setState(() {
        _isLoading = true;
      });
      fetchMovie(searchText);
    }

  }

  startTime() async {
    var _duration = new Duration(seconds: 4);
    //return new Timer(_duration, navigationPage);
  }

  showSnackBar(String msg){
    //showToast(msg, position: ToastPosition.bottom);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }

  fetchMovie(String searchText) async {

    final response = await http.get('http://www.omdbapi.com/?s='+searchText+'&page=2&type=movie&apikey=848e1f7a');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //final json = jsonDecode(response.body);
      SearchResult result = SearchResult.fromJson(json.decode(response.body));
      /*List<Movie> list = (json.decode(response.body) as List)
          .map((data) => new Movie.fromJson(data))
          .toList();*/

      if(result.movies.length>0){

        setState(() {
          movieList = result.movies;
          _isLoading = false;
        });
      }
      else{
        showSnackBar('Inavlid User Name or Password');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      showSnackBar('Inavlid User Name or Password');
    }
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
                child: Image.network(movie.poster, ),
              ),
              Center(child: Text(movie.title, style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 10),),),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(movie.year, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10),),
                  Text(movie.imdbID, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10),),
                ],
              ),
            ]),);
  }
}