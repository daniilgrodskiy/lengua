import 'package:Lengua/authFiles/auth.dart';
import 'package:Lengua/authFiles/loginPage.dart';
import 'package:Lengua/onWillPopFunction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({this.auth, this.user});
  final BaseAuth auth;
  final FirebaseUser user;


  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  
  @override
  Widget build(BuildContext context) {

              print('Inside SettingsPage LOGIN/SIGN UP: ${widget.user.toString()}');

    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: Text(
          "Settings",
          style: TextStyle(
            fontFamily: 'viga',
          ),
        ),
        // actions: <Widget>[
        //   new FlatButton(
        //     child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white),),
        //     onPressed: () async {
        //       try {
        //         await FirebaseAuth.instance.signOut();
        //         print('Signed out successfully');
        //         Navigator.of(context).push(MaterialPageRoute(
        //           builder: (BuildContext context) => LoginPage(auth: widget.auth)
        //         ));
        //       }
        //       catch (e) {
        //         print(e);
        //       }
        //     },
        //   )
        // ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text('Welcome ${widget.user.email.toString()}!', style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: settingsOption('Change email', (){}, Colors.white),
          ),
          settingsOption('Contact support', (){}, Colors.white),
          Container(
            // padding: const EdgeInsets.only(top: 30.0),
            child: settingsOption(
              'Log out',
              () async {
              try {
                await FirebaseAuth.instance.signOut();
                print('Signed out successfully');
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(auth: widget.auth)
                ));
              }
              catch (e) {
                print(e);
              }
            }, 
            Colors.red[100]),
          ),
        ],
      ),
    );
  }

    Widget settingsOption(String title, onTap, Color color) {
      return InkWell(
        onTap: onTap,
          child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: Container(
            
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
              ),
              borderRadius: BorderRadius.circular(50.0),
              color: color
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  title,
                ),
              ),
            ),
          ),
        ),
      );
    }
}