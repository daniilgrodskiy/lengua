import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  //this is created just in case we ever want to change authenticaion methods; basically, it ensures that all forms of authentication MUST abide to having a method that returns Future<String> and contains two parameters, email and password; same names for everything of course

  signInWithEmailAndPassword(String email, String password);
  //originally returned Future<String>

  createUserWithEmailAndPassword(String email, String password);
  //originally returned Future<String>

  currentUser();
  //originally returned Future<String>

  Future<void> signOut();
  //originally returned Future<void>

}

class AuthThroughFirebase implements BaseAuth {

  //we are abiding to rules in BaseAuth
  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return user;
  }
  
  Future<FirebaseUser> createUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }
  
}