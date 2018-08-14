import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'generalTopicsPage.dart';
import 'specificTopicsPage.dart';
import 'main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class QuestionPage extends StatefulWidget {

  final generalTopicIndex;
  final specificTopicIndex;
  final appBarTitle;
  final user;
  final googleSignIn;
  
  //appBarTitle currently doesn't work

  var passedInIndex = 0;
  var numberCorrect = 0;


  QuestionPage({
    this.generalTopicIndex, 
    this.appBarTitle, 
    this.specificTopicIndex, 
    this.passedInIndex,
    this.numberCorrect,
    this.user,
    this.googleSignIn,
  });


  @override
  _QuestionPageState createState() => new _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {


  

  void _updateQuestions() {

    //use this function to update any question category

    for (int index = 1; index <= 8; index++) {

      var answers = [
        'correct',
        'correct',
        'correct',

        'correct',
        'correct',
        'correct',
        'correct',
        'correct',
        'correct',
        'correct',
        'correct',
      ];

      var o1 = [
        'wrong1',
        'wrong1',
        'wrong1',

        "wrong",
        'wrong', 
        'wrong', 
        'wrong', 
        'wrong', 
        'correct', 
        'wrong', 
        'wrong', 
      ];

      var o2 = [
        'wrong2',
        'correct', 
        'wrong2',

        "correct",
        'wrong', 
        'wrong', 
        'wrong', 
        'wrong', 
        'wrong', 
        'wrong', 
        'correct',
      ];

      var o3 = [
        'correct', 
        'wrong3', 
        'wrong3',

        "wrong",
        'wrong', 
        'correct', 
        'wrong', 
        'correct', 
        'wrong', 
        'wrong', 
        'wrong',
        

      ];

      var o4 = [
        'wrong4', 
        'wrong4', 
        'correct',

        "wrong",
        'correct', 
        'wrong', 
        'correct', 
        'wrong', 
        'wrong', 
        'correct', 
        'wrong',

      ];

      var titles = [
        'having?',
        "no i am not",
        "i hope it worked lol",

        "okay imma start not",
        "nope",
        "Que ustedes en mi casa por favor? Estoy muy stupendo para estoy cansando en este profesora.",
        "yuh",
        "Red",
        "Just listen up",
        "Okay what is up",
        "nah stop that, okay?"
      ];


      final DocumentReference documentReference = 
      Firestore.instance.document(
        "/content/adverbs/specificTopics/formingAdverbs/questions/" + index.toString()
      );
      //just change the 'formingAdjectives', e.g. the section AFTER specificTopics

      
      Map<String, String> data = <String, String> {
        'title' : titles[index - 1],
        'answer' : answers[index - 1],
        'o1' : o1[index - 1],
        'o2' : o2[index - 1],
        'o3' : o3[index - 1],
        'o4' : o4[index - 1],
      };
      //might need to change the plus or minus after the index

      documentReference.setData(data).whenComplete(() {
        print("Document Updated");
      }).catchError((e) => print(e));

    }
  }

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

  @override
    void initState() {
      super.initState();
      // print(widget.generalTopicIndex);
      // print(widget.specificTopicIndex);
    }
  
  @override
  Widget build(BuildContext context) {

    

    return new Scaffold(
      // appBar: AppBar(
        
      //   // title: Text(widget.appBarTitle.toString()),
      //   title: Text(
      //     "Lengua",
      //     style: TextStyle(
      //       // fontWeight: FontWeight.bold,
      //       fontFamily: "viga",
      //     ),
      //   ),
      //   leading: IconButton(
      //       onPressed: () {
      //         showDialog(
      //           context: context,
      //           builder: (BuildContext context) =>
      //             AlertDialog(
      //               content: Container(
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(20.0)
      //                 ),
      //                 height: 200.0,
      //                 child: Column(
      //                   children: <Widget>[
      //                     Padding(
      //                       padding: const EdgeInsets.all(16.0),
      //                       child: Text(
      //                         "Are you sure you want to exit this quiz? Your progress will not be saved.",
      //                         style: TextStyle(
      //                           fontSize: 16.0
      //                         ),
      //                         textAlign: TextAlign.center,
      //                       ),
      //                     ),
      //                     Divider(),
      //                     Padding(padding: EdgeInsets.only(bottom: 10.0),),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                       children: <Widget>[
      //                         InkWell(
      //                           onTap: (){
      //                               Navigator.push(context, MaterialPageRoute(
      //                                 builder: (context) => SpecificTopicsPage(
      //                                   generalTopicIndex: widget.generalTopicIndex, 
      //                                   appBarTitle: widget.appBarTitle, 
      //                                 )
      //                               ));
      //                             },
      //                           child: Container(
      //                             padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      //                             child: Column(
      //                               children: <Widget>[
      //                                 Icon(Icons.check, color: Colors.black,),
      //                                 Padding(
      //                                   padding: EdgeInsets.all(5.0),
      //                                 ),
      //                                 Text(
      //                                   "Yes",
      //                                   style: TextStyle(color: Colors.black),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                         InkWell(
      //                           onTap: () {
      //                             Navigator.pop(context);
      //                           },
      //                           child: Container(
      //                             padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      //                             child: Column(
      //                               children: <Widget>[
      //                                 Icon(Icons.close),
      //                                 Padding(
      //                                   padding: EdgeInsets.all(5.0),
      //                                 ),
      //                                 Text("Cancel"),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //         );
      //       },
      //       // alignment: Alignment.centerRight,
      //       icon: Icon(Icons.cancel, color: Colors.white,),
      //   ),
      // ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics/" + widget.specificTopicIndex + "/questions").snapshots(),
          builder: (BuildContext context, 
          AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return _buildQuestionPage(context, snapshot.data.documents[widget.passedInIndex], snapshot.data.documents.length, widget.passedInIndex);
              // return ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   // itemExtent: 10.0,
              //   itemCount: snapshot.data.documents.length,
              //   itemBuilder: (BuildContext context, int index) =>
              //     _buildSpecificItems(context, snapshot.data.documents[index], snapshot.data.documents.length, index)
              // );
              //return FirestoreListView(documents: snapshot.data.documents);
            }
          },
        ),
      ),
    );
  }

  Widget _checkAndCreateAnswer(optionNumber, document, index, documentLength,  ) {

    var optionColor = Colors.white;

    //creates and checks answer options
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: InkWell(
        borderRadius: new BorderRadius.circular(30.0),
      
        onTap: () {
          setState(() {
            optionColor = Colors.grey;   
          });
          if (document['o' + '$optionNumber'] == document['answer']) {
            //checks if you clicked the right answer
            print("Correct!");
            if (index == documentLength - 1) {
              //checks if you're on the last question
              print("We're done here!");
              //update Firestore with highScore
              //check if current score is larger than the previous one

              //pass in current number correct PLUS the one you get right at the end into the final stats page screen

              _updateScores(widget.numberCorrect + 1, documentLength);


              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SpecificTopicsPage(
                  generalTopicIndex: widget.generalTopicIndex, 
                  appBarTitle: widget.appBarTitle, 
                  user: widget.user,
                  googleSignIn: widget.googleSignIn,
                )
              ));





            }
            else {
              //if not last question, push to next question with an passedInIndex increased by one; passedInIndex value will be used to retrieve document
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => QuestionPage(
                    generalTopicIndex: widget.generalTopicIndex, specificTopicIndex: widget.specificTopicIndex,
                    passedInIndex: index + 1,
                    appBarTitle: widget.appBarTitle,
                    numberCorrect: widget.numberCorrect + 1,
                    user: widget.user,
                    googleSignIn: widget.googleSignIn,
                  ),
                ));
              }
            }
          else {
            //what happens if answer is inccorect
            print("Answer is incorrect!");
            if (index == documentLength - 1) {
              //checks if you're on the last question
              print("We're done here!");
              //update Firestore with highScore
              //check if current score is larger than the previous one

              //pass in current number correct


              _updateScores(widget.numberCorrect, documentLength);

              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SpecificTopicsPage(
                  generalTopicIndex: widget.generalTopicIndex, 
                  appBarTitle: widget.appBarTitle, 
                  user: widget.user,
                  googleSignIn: widget.googleSignIn,
                )
              ));

              

            }
            else {
              //if not last question, push to next question with an passedInIndex increased by one; passedInIndex value will be used to retrieve document
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => QuestionPage(
                    generalTopicIndex: widget.generalTopicIndex, specificTopicIndex: widget.specificTopicIndex,
                    passedInIndex: index + 1,
                    appBarTitle: widget.appBarTitle,
                    numberCorrect: widget.numberCorrect,
                    user: widget.user,
                    googleSignIn: widget.googleSignIn,
                  ),
                ));
              }
            }
          },
        
        
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              // color: optionColor,
              border: Border.all(
              ),
              borderRadius: BorderRadius.circular(50.0)
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                document['o' + '$optionNumber'],
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionPage(BuildContext context, DocumentSnapshot document, int documentLength, int index) {

    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    final double barHeight = 66.0;

      
    return GestureDetector(
      onTap: (){
        // print(document.reference.toString());
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) => QuestionPage(generalTopicIndex: document.documentID,)
        // ));
      },

      
      
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 80.0,
            color: Colors.blue,
            child: 
          
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          // alignment: FractionalOffset.centerRight,
                          padding: EdgeInsets.only(left: 45.0),
                          child: Center(
                            child: Text(
                                "Question "
                                "${index + 1}" +
                                " of " +
                                "${documentLength.toString()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontFamily: "viga",
                                  
                                ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                    AlertDialog(
                      content: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        height: 200.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Are you sure you want to exit this quiz? Your progress and score will not be saved.",
                                style: TextStyle(
                                  fontSize: 16.0
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Divider(),
                            Padding(padding: EdgeInsets.only(bottom: 10.0),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => SpecificTopicsPage(
                                          generalTopicIndex: widget.generalTopicIndex, 
                                          appBarTitle: widget.appBarTitle, 
                                          user: widget.user,
                                          googleSignIn: widget.googleSignIn,
                                        )
                                      ));
                                    },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.check, color: Colors.black,),
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                        ),
                                        Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.close),
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                        ),
                                        Text("Cancel"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              );
            },
            // alignment: Alignment.centerRight,
            icon: Icon(FontAwesomeIcons.times, color: Colors.white,),
        ),
  
                      ),
                    ],
                  ),
                ),
          ),

          Container(
            child: Text("Number correct: " + widget.numberCorrect.toString()),
          ),
              
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Text(
              document['title'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),          
          ),
          _checkAndCreateAnswer(1, document, index, documentLength),
          _checkAndCreateAnswer(2, document, index, documentLength),
          _checkAndCreateAnswer(3, document, index, documentLength),
          _checkAndCreateAnswer(4, document, index, documentLength),
          MaterialButton(
            child: Text("UPDATE!!!"),
            color: Colors.orange,
            onPressed: _updateQuestions,
          ),

        ],
      ),
    );
  }
}



          // GestureDetector(
          //   onTap: () {
          //   },
          //   child: Container(
          //     //padding: new EdgeInsets.only(top: statusBarHeight),
          //     decoration: BoxDecoration(
          //       color: Colors.blueAccent,
          //       // borderRadius: BorderRadius.only(
          //       //   bottomLeft: Radius.circular(10.0),
          //       //   bottomRight: Radius.circular(10.0)
          //       // ),
          //     ),
              
          //     width: double.infinity,
          //     height: statusBarHeight + barHeight,
          //     child: Row(
          //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          //       children: <Widget>[
          //         Container(
          //           // margin: EdgeInsets.all(16.0),
          //           // alignment: Alignment.center,
          //           // margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 2, 0.0, 0.0, 0.0),
          //           child: Text(
          //             "Question "
          //             "${index + 1}" +
          //             " of " +
          //             "${documentLength.toString()}",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               color: Colors.white,
          //               // fontWeight: FontWeight.bold,
          //               fontFamily: "viga"
          //             ),

          //           ),
          //         ),
          //         Text(
          //           "Lengua",
          //           style: TextStyle(
          //             fontFamily: "viga",
          //             color: Colors.white,
          //             fontSize: 20.0
          //           ),
          //         ),
          //           IconButton(
          //             onPressed: () {
          //               showDialog(
          //                 context: context,
          //                 builder: (BuildContext context) =>
          //                   AlertDialog(
          //                     content: Text("Are you sure you want to exit?"),
          //                   ),
          //               );
          //             },
          //             // alignment: Alignment.centerRight,
          //             icon: Icon(Icons.cancel, color: Colors.white,),
          //         ),
          //       ],
          //     ),
              
          //   ),
          // ),