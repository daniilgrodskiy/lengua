import 'package:Lengua/quizPortion/controller/correctWrongOverlay.dart';
import 'package:Lengua/generalTopicsPage.dart';
import 'package:Lengua/quizPortion/controller/scorePage.dart';
import 'package:Lengua/quizPortion/model/quiz.dart';
import 'package:Lengua/quizPortion/view/directionsContainer.dart';
import 'package:Lengua/quizPortion/view/optionButton.dart';
import 'package:Lengua/quizPortion/view/progressBar.dart';
import 'package:Lengua/quizPortion/view/questionText.dart';
import 'package:Lengua/quizPortion/view/scoreSoFar.dart';
import 'package:Lengua/specificTopicsPage.dart';
import 'package:Lengua/quizPortion/model/question.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Lengua/authFiles/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'generalTopicsPage.dart';
// import 'specificTopicsPage.dart';
// import 'main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'onWillPopFunction.dart';



class QuizPage extends StatefulWidget {

  final String specificTopicIndex;
  final String generalTopicIndex;
  final String appBarTitle;
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  final BaseAuth auth;
  // final List<Question> realQuestionList;

  QuizPage(this.specificTopicIndex, this.generalTopicIndex, this.user, this.googleSignIn, this.auth, this.appBarTitle);

  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  void _updateScores(int numberCorrectFinal, documentLength) {


      final DocumentReference documentReference = 
      Firestore.instance.document(
        "/userScores/" + widget.user.email.toString()
        //user scores
      );
      //check to see if number correct final is higher than the one before

      
      Map<String, String> data = <String, String> {
        widget.specificTopicIndex : numberCorrectFinal.toString() 
        + " out of "
        + "$documentLength"
      };


    documentReference.get().then((snapshot){
      if (snapshot.exists) {
        setState(() {
          var fullValueString = snapshot.data[widget.specificTopicIndex];

          if (fullValueString == null) {
            //runs if the user has been made but it's the first time they played this specific quiz
            documentReference.setData(data, merge: true).whenComplete(() {
              print(widget.specificTopicIndex + " updated");
            }).catchError((e) => print(e));
          }

          //bottom only runs if the user has already played this specific quiz before
          var fullValueStringList = fullValueString.split(" ");
          var valueString = fullValueStringList[0];
          var valueNumber = int.parse(valueString);
          
          if (numberCorrectFinal > valueNumber) {
            //checks to see if the new score is larger than the previous high score
            documentReference.setData(data, merge: true).whenComplete(() {
              print(widget.specificTopicIndex + " updated");
            }).catchError((e) => print(e));
          }
        });
      } else {
        //only runs if the user document has never been made; e.g. user has deleted all their data or it's the first time they played a quiz
        documentReference.setData(data, merge: true).whenComplete(() {
          print(widget.specificTopicIndex + " updated");
        }).catchError((e) => print(e));
      }
    }).catchError((e) => print(e));
  }


  Question currentQuestion;

  Quiz quiz = new Quiz([]);
  //[Question(0, 'Error getting question', 'Error getting question', 'Error getting question', 'Error getting question', 'Error getting question', 'Error getting question', 'Error getting question', 'Error getting question')]
  
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  StreamSubscription<QuerySnapshot> subscription;


  //Uneeded Variables
  List<String> titleList = [];
  int pageLength;
  // String questionText;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


          
    subscription = Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics/" + widget.specificTopicIndex + "/questions").snapshots().listen((snapshot) {

      setState(() {

        pageLength = snapshot.documents.length;

        for (int i = 0; i < snapshot.documents.length; i++) {

      

          String title = snapshot.documents[i].data['title'];
          String answer = snapshot.documents[i].data['answer'];
          String o1 = snapshot.documents[i].data['o1'];
          String o2 = snapshot.documents[i].data['o2'];
          String o3 = snapshot.documents[i].data['o3'];
          String o4 = snapshot.documents[i].data['o4'];
          String directions = snapshot.documents[i].data['directions'];
          String explanation = snapshot.documents[i].data['explanation'];

          // titleList.add(title);

          quiz.questions.add(
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
              // quiz.questions.shuffle();
              // print(quiz.questions[i].title);
        }
        // print(quiz.questions);


    });
        currentQuestion = quiz.nextQuestion;
        // questionText = currentQuestion.title;
        questionNumber = quiz.questionNumber;
  });



    
  }

  void handleAnswer(String answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState((){
      overlayShouldBeVisible = true;
    });
  }

  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // print(quiz.length);
    print("Question number:" + questionNumber.toString());
    // quiz.questions.shuffle();

    // print(questionNumber);
    // print('list:::::' + widget.realQuestionList[questionNumber].o1);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            AppBar(
              
                backgroundColor: Colors.orange[200],
                elevation: 0.0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  "Question $questionNumber / ${quiz.length}", 
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                      icon: Icon(FontAwesomeIcons.timesCircle),
                  ),
                ],
              ), 
              ProgressBar(
                questionNumber == null ? 0 : questionNumber,
                quiz?.length == null ? 0 : quiz?.length
              ),
              DirectionsContainer(currentQuestion?.directions == null ? 'Error getting question. Sorry!' : currentQuestion?.directions),
              QuestionText(currentQuestion?.title == null ? 'Error getting question. Sorry!' : currentQuestion?.title, questionNumber),
              buildOptionButton(currentQuestion?.o1, 1),
              buildOptionButton(currentQuestion?.o2, 2),
              buildOptionButton(currentQuestion?.o3, 3),
              buildOptionButton(currentQuestion?.o4, 4),
              Container(margin: EdgeInsets.all(10.0)),
              // ScoreSoFar(quiz.score, quiz.numberWrong),
            ],
          ),
             
              overlayShouldBeVisible == true 
              ?
                CorrectWrongOverlay(
                  isCorrect, 
                  () {
                    if (quiz.length == questionNumber) {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (BuildContext context) => ScorePage(quiz.score, quiz.length)
                      // ));
                      // return;
                      _updateScores(quiz.score, quiz.length);
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (BuildContext context) => 
                          ScorePage(
                              widget.generalTopicIndex,
                              widget.specificTopicIndex,
                              widget.appBarTitle,
                              widget.user,
                              widget.googleSignIn,
                              widget.auth,
                              quiz.score,
                              quiz.length
                            )
                          ), 
                        (Route route) => route == MaterialPageRoute(
                        builder: (BuildContext context) => 
                        SpecificTopicsPage(
                          generalTopicIndex: widget.generalTopicIndex, 
                          appBarTitle: widget.appBarTitle,
                          user: widget.user,
                          googleSignIn: widget.googleSignIn,
                          auth: widget.auth,
                        ),));
                      return;
                    }
                    currentQuestion = quiz.nextQuestion;
                    this.setState(() {
                      overlayShouldBeVisible = false;
                      // questionText = currentQuestion.title;
                      questionNumber = quiz.questionNumber;
                    });
                  },
                  currentQuestion.explanation
                )  
              : 
                Container()
        ],
      ),
    );
  }

  Widget buildOptionButton(String option, int optionNumber) {
    return OptionButton(
      option == null ? 'Error getting question. Sorry!' : option,
      optionNumber,
      () {
        handleAnswer(
          option == null ? 'Error getting question. Sorry!' : option
        );
      },
      questionNumber == null ? 0 : questionNumber,
    );
  }


}

