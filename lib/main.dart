import 'package:Lengua/authFiles/auth.dart';
import 'package:Lengua/authFiles/loginPage.dart';
import 'package:Lengua/authFiles/rootPage.dart';
import 'package:Lengua/generalTopicsPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lengua',
      theme: new ThemeData(
        // primarySwatch: Colors.blue,
        fontFamily: "avenir-next"
      ),
      routes: {
        "/generalTopicsPage": (context) => GeneralTopicsPage(),
         "/loginPage": (context) => LoginPage(),
        //might not work right now because the "googleSignIn" parameter might be useful later on
      },
      home: RootPage(auth: AuthThroughFirebase()),
    );
  }
}