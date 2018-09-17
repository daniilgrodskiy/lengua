import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'specificTopicsPage.dart';
// import 'package:spanish_grammar_app_flutter/generalTopicsPage.dart';
import 'generalTopicsPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  //Lengua - Spanish Grammar App
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lengua',
      theme: new ThemeData(
        // primarySwatch: Colors.blue,
        fontFamily: "avenir-next"
      ),
      home: new LoginPage(),
      routes: {
        "/generalTopicsPage": (context) => GeneralTopicsPage(),
         "/loginPage": (context) => LoginPage(),
        //might not work right now because the "googleSignIn" paramter might be useful later on
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  void _signOut() {
    googleSignIn.signOut();
    print("User signed out");
  }

  Future<FirebaseUser> _signIn() async {

    GoogleSignInAccount googleSignInAccount = 
      await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = 
      await googleSignInAccount.authentication;

    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => 
        new GeneralTopicsPage(
          user: firebaseUser, 
          googleSignIn: googleSignIn
        ),
      ),
    );
  } 

  var _loginButtonController;
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      TextEditingController userController;
      TextEditingController passwordController;

      _loginButtonController = new AnimationController(
        duration:  Duration(milliseconds: 3000),
        vsync: this,
      );
    }

  // Future<Null> _playAnimation() async {
  //   try {
  //     await _loginButtonController.forward();
  //     await _loginButtonController.reverse();
  //   }
  //   on TickerCanceled{}
  // }

  // var buttonSqueezeAnimation = new Tween(
  //   begin: double.infinity,
  //   end: 70.0,
  // ). animate(CurvedAnimation(
  //   parent: buttonController,
  //   curve: Interval(0.0, 0.250)
  // ));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      //   title: Text("Flutter Test"),
      // ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.orange[300],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFFf59d2a),
              Color(0xFFee7738), 
            ]
          )
          // image: DecorationImage(
          //   image: AssetImage("assets/wallpaper.jpg"),
          //   fit: BoxFit.cover
          // )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            
            Column(
              children: <Widget>[
                // Container(
                //   padding: const EdgeInsets.only(top: 20.0),
                //   child: Image.asset(
                //     "assets/spanish_flag.png",
                //     width: 100.0,
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),
                  child: Text(
                    "Lengua",
                    style: TextStyle(
                      fontFamily: "viga",
                      // fontWeight: FontWeight.bold,
                      fontSize: 75.0,
                      // color: Colors.deepOrange[900]
                      color: Colors.white
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                  child: Text(
                    "The Spanish grammar app",
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange[200],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [BoxShadow(
                  color: Colors.black12,
                  blurRadius: 50.0,
                  spreadRadius: 2.0
                ),]
              ),
              margin: EdgeInsets.all(16.0),
              // padding: EdgeInsets.all(16.0),
              // color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Colors.orangeAccent,
                        // accentColor: Colors.orange[900],
                        hintColor: Colors.grey[800]
                      ),
                      child: new TextField(
                        decoration: new InputDecoration(
                          // hintText: "Enter your email",
                          labelText: "Email",
                          labelStyle: new TextStyle(color: Colors.grey[800]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                    child: new Theme(
                      data: new ThemeData(
                        // primaryColor: Colors.amber[200],
                        primaryColor: Colors.orangeAccent,
                        // accentColor: Colors.orange[900],
                        hintColor: Colors.grey[800]
                      ),
                      child: new TextField(
                        decoration: new InputDecoration(
                          // hintText: "Enter your password",
                          labelText: "Password",
                          labelStyle: new TextStyle(color: Colors.grey[800]),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      // _signIn();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                          ),
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Sign In"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(color: Colors.grey[800],),
            // ),
            
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: InkWell(
                onTap: () => _signIn(),
                child: Image.asset(
                  "assets/google_sign_in.png",
                  width: 200.0,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                onTap: () => _signOut(),
                child: Center(
                  child: Container(
                    child: Center(child: Text("Sign Out")),
                    color: Colors.orange,
                    width: 200.0,
                    height: 50.0
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}