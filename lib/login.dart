import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movie.dart';
import 'dart:convert';
import 'search_movie.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isClicked = false;

  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  Future<Movie> movie;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: new ExactAssetImage('assets/login_bg.jpg'),
              )
          ),
          child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 10.0,right: 10.0),
                child: Card(
                  color: Color.fromRGBO(255, 153, 153, 0.55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _userNameController,
                          obscureText: false,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                              hintText: "User Name",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              prefixIcon: Padding(
                                child: IconTheme(
                                  data: IconThemeData(color: Colors.white),
                                  child: Icon(Icons.person),
                                ),
                                padding: EdgeInsets.only(left: 30, right: 10),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          maxLength: 4,
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              prefixIcon: Padding(
                                child: IconTheme(
                                  data: IconThemeData(color: Colors.white),
                                  child: Icon(Icons.lock),
                                ),
                                padding: EdgeInsets.only(left: 30, right: 10),
                              )),
                        ),
                      ),
                      Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: Alignment.center,
                            child: FlatButton(
                              child: Text(
                                "GO",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              onPressed: (){
                                setState(() {
                                  isClicked = !isClicked;
                                });
                                //showToast("OnTap", position: ToastPosition.bottom);
                                loginUser();
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              )
          )
      ),
    );
  }

  void loginUser() async{
    String user = _userNameController.text;
    String password = _passwordController.text;
    if(user.length==0 || password.length==0){
     showSnackBar('Please fill User Name and Password');
    }
    else{
     fetchMovie(user, password);
    }
  }

   fetchMovie(String movie, String year) async {

    movie = movie.trim().replaceAll(" ", "+");
    final response = await http.get('http://www.omdbapi.com/?t='+movie+'&y='+year+'&apikey=848e1f7a');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //final json = jsonDecode(response.body);
     Movie movie = Movie.fromJson(json.decode(response.body));
     if(movie!=null && movie.title!=null){
       Navigator.pushReplacement(
         context,MaterialPageRoute(builder: (context) => SearchMovie()),);
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

  showSnackBar(String msg){
    //showToast(msg, position: ToastPosition.bottom);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }


}
