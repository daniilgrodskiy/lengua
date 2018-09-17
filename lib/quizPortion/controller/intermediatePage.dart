import 'dart:async';

import 'package:Lengua/authFiles/auth.dart';
import 'package:Lengua/quizPortion/model/question.dart';
import 'package:Lengua/quizPortion/model/quiz.dart';
import 'package:Lengua/quizPortion/view/quizPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class IntermediatePage extends StatefulWidget {

  final String specificTopicIndex;
  final String generalTopicIndex;
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  final BaseAuth auth;
  final String appBarTitle;

  const IntermediatePage(this.specificTopicIndex, this.generalTopicIndex, this.user, this.googleSignIn, this.auth, this.appBarTitle);

  
  @override
  _IntermediatePageState createState() => new _IntermediatePageState();
}

class _IntermediatePageState extends State<IntermediatePage> {

  Question currentQuestion;

  Quiz quiz;

  List<Question> listOfQuestions = [Question(0, 'hey', 'hey', 'hey', 'hey', 'hey', 'hey', 'hey', 'hey',)];

  // List<Question> listOfQuestions = [Question(0, 'hey', 'hey', 'hey', 'hey', 'hey', 'hey', 'hey', 'hey',)];
  
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  StreamSubscription<QuerySnapshot> subscription;


  //Uneeded Variables
  List<String> titleList = [];
  int pageLength;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics/" + widget.specificTopicIndex + "/questions").snapshots().listen((snapshot) {
      setState(() {

        quiz = Quiz(
          listOfQuestions
        );

        currentQuestion = quiz.nextQuestion;
        questionText = currentQuestion.title;
        questionNumber = quiz.questionNumber;
        
        pageLength = snapshot.documents.length;

        for (int i = 0; i < snapshot.documents.length; i++) {
          
          String title = snapshot.documents[i].data['title'];
          print(title);
          String answer = snapshot.documents[i].data['answer'];
          String o1 = snapshot.documents[i].data['o1'];
          String o2 = snapshot.documents[i].data['o2'];
          String o3 = snapshot.documents[i].data['o3'];
          String o4 = snapshot.documents[i].data['o4'];
          String directions = snapshot.documents[i].data['directions'];
          String explanation = snapshot.documents[i].data['explanation'];

          titleList.add(title);

          listOfQuestions.add(
            Question(
              i,
              title,
              answer,
              o1,
              o2,
              o3,
              o4,
              directions,
              explanation,
            )
          );
          // print('HEYGADJGSDAKHSDKJASHJKADHS: ' + listOfQuestions.toString());
        }
      });
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    print(listOfQuestions);
    return new Material(
      child: Center(
        child: InkWell(

          onTap: () {
          Navigator.push(context, MaterialPageRoute(
          builder: (context) => QuizPage(
            widget.specificTopicIndex,
            widget.generalTopicIndex,
            widget.user,
            widget.googleSignIn,
            widget.auth,
            // listOfQuestions
            widget.appBarTitle,
          )
        ));
          },
          child: Text(
            "Start"
          ),
        ),
      ),
    );
  }
}