// import 'dart:async';
// import 'package:Lengua/authFiles/auth.dart';
// import 'package:Lengua/generalTopicsPage.dart';
// import 'package:Lengua/specificTopicsPage.dart';
// import 'package:Lengua/quizPortion/model/question.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class QuizPage2 extends StatefulWidget {

//   const QuizPage2(this.generalTopicIndex, this.appBarTitle, this.user, this.googleSignIn, this.auth, this.specificTopicIndex);

//   @override
//   _QuizPage2State createState() => new _QuizPage2State();

//   final generalTopicIndex;
//   final specificTopicIndex;
//   final appBarTitle;
//   final FirebaseUser user;
//   final GoogleSignIn googleSignIn;
//   //appBarTitle currently doesn't work
//   final BaseAuth auth;
// }

// class _QuizPage2State extends State<QuizPage2> {

//   List<Question> listOfQuestions;

//   int pageLength;
//   StreamSubscription<QuerySnapshot> subscription;
  

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     subscription = Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics/" + widget.specificTopicIndex + "/questions").snapshots().listen((snapshot) {
//               print(snapshot.documents);

//       setState(() {
//         int index = 0;
//         print(snapshot.documents.length);
//         snapshot.documents.forEach((document){
//           print(document.data);
//           listOfQuestions.add(
//             Question(index, document['title'], document['answer'], document['o1'], document['o2'], document['o3'], document['o4'], document['directions'],document['explanation'])
//           );
//           index++;
//           print(listOfQuestions);

//         });
//         pageLength = snapshot.documents.length;
//         // print(pageLength);
//       });
//     });
//     // currentQuestion = quiz.nextQuestion;
//     // questionText = currentQuestion.question;
//     // questionNumber = quiz.questionNumber;
//   }

//   // void handleAnswer(bool answer) {
//   //   isCorrect = (currentQuestion.answer == answer);
//   //   quiz.answer(isCorrect);
//   //   this.setState((){
//   //     overlayShouldBeVisible = true;
//   //   });
//   // }

//   void dispose() {
//     super.dispose();
//     subscription?.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: Center(
//         child: Material(
//           child: InkWell(
//             onTap: () => Navigator.pop(context),
//             child: Text("Go back"),
//           ),
//         ),
//       ),
//     );
//   }
// }