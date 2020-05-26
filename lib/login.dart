import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        controller: _emailController,
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
                          child: Text(
                            "GO",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            )
        )
    );
  }
}
