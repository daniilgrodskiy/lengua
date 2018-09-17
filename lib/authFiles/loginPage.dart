import 'package:Lengua/generalTopicsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  // LoginPage({this.auth, this.onSignedIn});
  LoginPage({this.auth});

  final BaseAuth auth;
  //by making auth of type BaseAuth, we are making the type of the authentication that we will use for the app flexible; we might at one point switch our ways of signing in, but as long as those ways abide to the rules in BaseAuth, then we're all good; basically, we don't ever need to know about what our method of signing in truly is, all we need to know is that it in fact abides to the rules set in palce by BaseAuth

  // final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType {
  //two states that our Form can be in: login or register
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  //will be used to access the validator and save functions in forms

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  String _email;
  String _password;
  FormType _formType = FormType.login;
  bool _error = false;
  String _errorMessage = 'There was an error.';

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login){
          _scaffoldKey.currentState.hideCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Colors.green[300],
              content: Container(
                child: Text('Signing user in...')
              ),
              duration: Duration(seconds: 5),
            )
          );
          FirebaseUser user = await widget.auth.signInWithEmailAndPassword(_email, _password);

              // print('Inside loginPage LOGIN: ${widget.auth}');

          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => GeneralTopicsPage(auth: widget.auth, user: user,)
          ));
          // print('Signed in: $userId');
         
        } else {
          _scaffoldKey.currentState.hideCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Colors.green[300],
              content: Container(
                child: Text('Signing user in...')
              ),
              duration: Duration(seconds: 5),
            )
          );
          FirebaseUser user = await widget.auth.createUserWithEmailAndPassword(_email, _password);



              // print('Inside loginPage SIGN UP: ${widget.auth}');

          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => GeneralTopicsPage(auth: widget.auth, user: user,)
          ));
          // print('Registered user: $userId');
        }
        // widget.onSignedIn();
      } catch(error) {
        print(error);
        setState(() {
          _error = true;
          String errorString = error.toString();
          List<String> errorList = errorString.split(', ');
          print(errorList[2].substring(0, errorList[2].length - 1));
          String realError = errorList[2].substring(0, errorList[2].length - 1);
          // Scaffold.of(context).showSnackBar(errorSnackBar);

          if (realError == 'There is no user record corresponding to this identifier. The user may have been deleted.') {
            _errorMessage = 'There is no user associated with this email.';
          } else if (realError == 'The email address is badly formatted.') {
            _errorMessage = 'The email address is badly formatted. Please don\'t forget the \'@\' as well as the top-level domain (.com, .edu, .net, etc.).';
          } else if (realError == 'The password must be 6 characters long or more.') {
            _errorMessage = 'The password must be 6 characters long or more.';
          } else if (realError == 'The password is invalid or the user does not have a password.') {
            _errorMessage = 'The password is invalid.';
          } else if (realError == 'The email address is already in use by another account.') {
            _errorMessage = 'This email address is taken.';
          }
          _scaffoldKey.currentState.hideCurrentSnackBar();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[300],
              content: Container(
                child: Text(_errorMessage)
              ),
              duration: Duration(seconds: 10),
            )
          );
        });
      }
    }
  }

  void moveToRegister() {
    setState(() {
      _error = false;
    });
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }
  
  void moveToLogin() {
    setState(() {
      _error = false;
    });
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }


  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs() + buildSubmitButtons()
                ),
              ),
            ),
          ],
        ),
      ),
    );
   
  }


  List<Widget> buildInputs() {
                  
    if (_formType == FormType.login) {
      return [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: new Theme(
            data: new ThemeData(
              primaryColor: Colors.orangeAccent,
              // accentColor: Colors.orange[900],
              hintColor: Colors.grey[800]
            ),
            child: new TextFormField(
              autocorrect: false,
              decoration: new InputDecoration(
                // hintText: "Enter your email",
                labelText: "Email",
                labelStyle: new TextStyle(color: Colors.grey[800]),
                
              ),
              validator: (value) => value.isEmpty ? "Email can't be empty" : null,
              onSaved: (value) => _email = value,
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
            child: new TextFormField(
              autocorrect: false,
              decoration: new InputDecoration(
                // hintText: "Enter your password",
                labelText: "Password",
                labelStyle: new TextStyle(color: Colors.grey[800]),
              ),
              obscureText: true,
              validator: (value) => value.isEmpty ? "Password can't be empty" : null,
              onSaved: (value) => _password = value,
            ),
          ),
        ),
      ];
    } else {
      return [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: new Theme(
            data: new ThemeData(
              primaryColor: Colors.orangeAccent,
              // accentColor: Colors.orange[900],
              hintColor: Colors.grey[800]
            ),
            child: new TextFormField(
              autocorrect: false,
              decoration: new InputDecoration(
                // hintText: "Enter your email",
                labelText: "Email",
                labelStyle: new TextStyle(color: Colors.grey[800]),
              ),
              validator: (value) => value.isEmpty ? "Email can't be empty" : null,
              onSaved: (value) => _email = value,
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
            child: new TextFormField(
              autocorrect: false,
              decoration: new InputDecoration(
                // hintText: "Enter your password",
                labelText: "Password",
                labelStyle: new TextStyle(color: Colors.grey[800]),
              ),
              obscureText: true,
              validator: (value) => value.isEmpty ? "Password can't be empty" : null,
              onSaved: (value) => _password = value,
            ),
          ),
        ),
      ];
    }
    
  }

  List<Widget> buildSubmitButtons() {

      
    if (_formType == FormType.login) {
      return [
          InkWell(
          onTap: validateAndSubmit,
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
        InkWell(
          onTap: moveToRegister,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 20.0),
            child: Container(
              padding: EdgeInsets.only(top: 5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1.0)),
                // borderRadius: BorderRadius.circular(50.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Create an account"
                  ),
                ),
              ),
            ),
          ),
        ),
      ];
    } else {
      return [

          InkWell(
          onTap: validateAndSubmit,
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
                    "Sign Up"
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: moveToLogin,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 20.0),
            child: Container(
              padding: EdgeInsets.only(top: 5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1.0)),
                // borderRadius: BorderRadius.circular(50.0)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    'Have an account? Login',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ];
    }
  }

}
