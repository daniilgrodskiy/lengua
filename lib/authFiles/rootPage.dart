import 'package:Lengua/generalTopicsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.notSignedIn;
  // FirebaseUser user = widget.user;
  FirebaseUser firebaseUser;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((user) {
      setState(() {
        authStatus = user.toString() == 'null' ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        firebaseUser = user;
        // print('Inside initState: $user');
      });
    });
    // widget.auth().then((userId) {
    //   setState(() {
    //     authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
    //   });
    // });
  }

  // void _signedIn() {
  //   setState(() {
  //     authStatus = AuthStatus.signedIn;
  //   });
  // }

  // void _signedOut() {
  //   setState(() {
  //     authStatus = AuthStatus.notSignedIn;
  //   });
  // }
  
  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth, 
        );
      case AuthStatus.signedIn:
        // print('About to go into home: $firebaseUser');
        return GeneralTopicsPage(
          auth: widget.auth, 
          user: firebaseUser,
          
        );
    }
  }
}