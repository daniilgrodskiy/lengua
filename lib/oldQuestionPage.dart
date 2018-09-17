// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'generalTopicsPage.dart';
// import 'specificTopicsPage.dart';
// import 'main.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';


// class QuestionPage extends StatefulWidget {

//   final generalTopicIndex;
//   final specificTopicIndex;
//   final appBarTitle;
//   final user;
//   final googleSignIn;
  
//   //appBarTitle currently doesn't work

//   var passedInIndex = 0;
//   var numberCorrect = 0;
//   var numberWrong = 0;


//   QuestionPage({
//     this.generalTopicIndex, 
//     this.appBarTitle, 
//     this.specificTopicIndex, 
//     this.passedInIndex,
//     this.numberCorrect,
//     this.numberWrong,
//     this.user,
//     this.googleSignIn,
//   });


//   @override
//   _QuestionPageState createState() => new _QuestionPageState();
// }

// class _QuestionPageState extends State<QuestionPage> {


  

//   void _updateQuestions() {

//     //use this function to update any question category

//     for (int index = 1; index <= 11; index++) {

//       var answers = [
//         'Rojo',
//         'Verde',
//         'Azul',
//         'Amarillo',
//         'Gris',
//         'Negro',
//         'Anaranjado',
//         'Blanco',
//         'Morado',
//         'Café',
//         'Rosa',
//       ];

//       var o1 = [
//         'Rojo',
//         'Morado',
//         'Verde',
//         'Rojo',
//         'Gris', 
//         'Anaranjado', 
//         'Morado', 
//         'Negro', 
//         'Morado', 
//         'Azul', 
//         'Café', 
//       ];

//       var o2 = [
//         'Amarillo',
//         'Verde', 
//         'Azul',
//         'Morado',
//         'Anaranjado', 
//         'Gris', 
//         'Amarillo', 
//         'Morado', 
//         'Gris', 
//         'Café', 
//         'Verde',
//       ];

//       var o3 = [
//         'Azul', 
//         'Gris', 
//         'Negro',
//         'Morado',
//         'Morado', 
//         'Negro', 
//         'Anaranjado', 
//         'Rosa', 
//         'Amarillo', 
//         'Azul', 
//         'Gris',
//       ];

//       var o4 = [
//         'Rosa', 
//         'Rojo', 
//         'Blueo',
//         'Amarillo',
//         'Griz', 
//         'Azul', 
//         'Rosa', 
//         'Blanco', 
//         'Morado', 
//         'Negro', 
//         'Rosa',
//       ];

//       var titles = [
//         'Red',
//         'Green',
//         'Blue',
//         'Yellow',
//         'Gray',
//         'Black',
//         'Orange',
//         'White',
//         'Purple',
//         'Que ustedes en mi basura, sino no ___ estoy moy super?',
//         //Brown
//         'Pink',
//       ];

//       var directions = [
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//         'Choose the Spanish translation of this color.',
//       ];

//       var explanation = [
//         'Rojo means "red" in Spanish. It helps to remember that they both start with the same letter.',
//         'Verde means "green" in Spanish. Thinking that VEgetables are green might help remember that VErde is green.',
//         'Azul means "blue" in Spanish.',
//         'Amarillo means "yellow" in Spanish. It\'s worth mentioning that both "yellow" and "amarillo" both have double letter Ls.',
//         'Gris means "gray" in Spanish. Both GRis and GRay start with "Gr."',
//         'Negro means "black" in Spanish.',
//         'Anaranjado means "orange" in Spanish.',
//         'Blanco means "white" in Spanish. It kind of sounds like "BLANK" piece of white paper.',
//         'Morado means "purple" in Spanish.',
//         'Café means "brown" in Spanish. Café kind of sounds like coffee so thinking of it might remind you that Café means brown.',
//         'Rosa means "pink" in Spanish. It might help to remember that some ROSes are pink.',
//       ];


//       final DocumentReference documentReference = 
//       Firestore.instance.document(
//         "/content/adjectives/specificTopics/colors/questions/" + index.toString()
//       );
//       //just change the 'formingAdjectives', e.g. the section AFTER specificTopics

      
//       Map<String, String> data = <String, String> {
//         'title' : titles[index - 1],
//         'answer' : answers[index - 1],
//         'o1' : o1[index - 1],
//         'o2' : o2[index - 1],
//         'o3' : o3[index - 1],
//         'o4' : o4[index - 1],
//         'directions' :  directions[index - 1],
//         'explanation' : explanation[index - 1],
//       };
//       //might need to change the plus or minus after the index

//       documentReference.setData(data).whenComplete(() {
//         print("Document Updated");
//       }).catchError((e) => print(e));

//     }
//   }

//   void _updateScores(int numberCorrectFinal, documentLength) {


//       final DocumentReference documentReference = 
//       Firestore.instance.document(
//         "/userScores/" + widget.user.email.toString()
//         //user scores
//       );
//       //check to see if number correct final is higher than the one before

      
//       Map<String, String> data = <String, String> {
//         widget.specificTopicIndex : numberCorrectFinal.toString() 
//         + " out of "
//         + "$documentLength"
//       };


//     documentReference.get().then((snapshot){
//       if (snapshot.exists) {
//         setState(() {
//           var fullValueString = snapshot.data[widget.specificTopicIndex];

//           if (fullValueString == null) {
//             //runs if the user has been made but it's the first time they played this specific quiz
//             documentReference.setData(data, merge: true).whenComplete(() {
//               print(widget.specificTopicIndex + " updated");
//             }).catchError((e) => print(e));
//           }

//           //bottom only runs if the user has already played this specific quiz before
//           var fullValueStringList = fullValueString.split(" ");
//           var valueString = fullValueStringList[0];
//           var valueNumber = int.parse(valueString);
          
//           if (numberCorrectFinal > valueNumber) {
//             //checks to see if the new score is larger than the previous high score
//             documentReference.setData(data, merge: true).whenComplete(() {
//               print(widget.specificTopicIndex + " updated");
//             }).catchError((e) => print(e));
//           }
//         });
//       } else {
//         //only runs if the user document has never been made; e.g. user has deleted all their data or it's the first time they played a quiz
//         documentReference.setData(data, merge: true).whenComplete(() {
//           print(widget.specificTopicIndex + " updated");
//         }).catchError((e) => print(e));
//       }
//     }).catchError((e) => print(e));

    
//   } 

//   @override
//     void initState() {
//       super.initState();
//       // print(widget.generalTopicIndex);
//       // print(widget.specificTopicIndex);
//     }
  
//   @override
//   Widget build(BuildContext context) {

    

//     return new Scaffold(
//       // appBar: AppBar(
        
//       //   // title: Text(widget.appBarTitle.toString()),
//       //   title: Text(
//       //     "Lengua",
//       //     style: TextStyle(
//       //       // fontWeight: FontWeight.bold,
//       //       fontFamily: "viga",
//       //     ),
//       //   ),
//       //   leading: IconButton(
//       //       onPressed: () {
//       //         showDialog(
//       //           context: context,
//       //           builder: (BuildContext context) =>
//       //             AlertDialog(
//       //               content: Container(
//       //                 decoration: BoxDecoration(
//       //                   borderRadius: BorderRadius.circular(20.0)
//       //                 ),
//       //                 height: 200.0,
//       //                 child: Column(
//       //                   children: <Widget>[
//       //                     Padding(
//       //                       padding: const EdgeInsets.all(16.0),
//       //                       child: Text(
//       //                         "Are you sure you want to exit this quiz? Your progress will not be saved.",
//       //                         style: TextStyle(
//       //                           fontSize: 16.0
//       //                         ),
//       //                         textAlign: TextAlign.center,
//       //                       ),
//       //                     ),
//       //                     Divider(),
//       //                     Padding(padding: EdgeInsets.only(bottom: 10.0),),
//       //                     Row(
//       //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //                       children: <Widget>[
//       //                         InkWell(
//       //                           onTap: (){
//       //                               Navigator.push(context, MaterialPageRoute(
//       //                                 builder: (context) => SpecificTopicsPage(
//       //                                   generalTopicIndex: widget.generalTopicIndex, 
//       //                                   appBarTitle: widget.appBarTitle, 
//       //                                 )
//       //                               ));
//       //                             },
//       //                           child: Container(
//       //                             padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
//       //                             child: Column(
//       //                               children: <Widget>[
//       //                                 Icon(Icons.check, color: Colors.black,),
//       //                                 Padding(
//       //                                   padding: EdgeInsets.all(5.0),
//       //                                 ),
//       //                                 Text(
//       //                                   "Yes",
//       //                                   style: TextStyle(color: Colors.black),
//       //                                 ),
//       //                               ],
//       //                             ),
//       //                           ),
//       //                         ),
//       //                         InkWell(
//       //                           onTap: () {
//       //                             Navigator.pop(context);
//       //                           },
//       //                           child: Container(
//       //                             padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
//       //                             child: Column(
//       //                               children: <Widget>[
//       //                                 Icon(Icons.close),
//       //                                 Padding(
//       //                                   padding: EdgeInsets.all(5.0),
//       //                                 ),
//       //                                 Text("Cancel"),
//       //                               ],
//       //                             ),
//       //                           ),
//       //                         ),
//       //                       ],
//       //                     ),
//       //                   ],
//       //                 ),
//       //               ),
//       //             ),
//       //         );
//       //       },
//       //       // alignment: Alignment.centerRight,
//       //       icon: Icon(Icons.cancel, color: Colors.white,),
//       //   ),
//       // ),
//       body: Container(
//         child: StreamBuilder(
//           stream: Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics/" + widget.specificTopicIndex + "/questions").snapshots(),
//           builder: (BuildContext context, 
//           AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return Container(
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             } else {
//               return _buildQuestionPage(context, snapshot.data.documents[widget.passedInIndex], snapshot.data.documents.length, widget.passedInIndex);
//               // return ListView.builder(
//               //   scrollDirection: Axis.vertical,
//               //   // itemExtent: 10.0,
//               //   itemCount: snapshot.data.documents.length,
//               //   itemBuilder: (BuildContext context, int index) =>
//               //     _buildSpecificItems(context, snapshot.data.documents[index], snapshot.data.documents.length, index)
//               // );
//               //return FirestoreListView(documents: snapshot.data.documents);
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _checkAndCreateAnswer(optionNumber, document, index, documentLength,  ) {

//     var optionColor = Colors.white;

//     //creates and checks answer options
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
//       child: InkWell(
//         borderRadius: new BorderRadius.circular(30.0),
      
//         onTap: () {
//           setState(() {
            
//             optionColor = Colors.grey; 
//           });
//           if (document['o' + '$optionNumber'] == document['answer']) {
//             //checks if you clicked the right answer
//             print("Correct!");
//             if (index == documentLength - 1) {
//               //checks if you're on the last question
//               print("We're done here!");
//               //update Firestore with highScore
//               //check if current score is larger than the previous one

//               //pass in current number correct PLUS the one you get right at the end into the final stats page screen

//               _updateScores(widget.numberCorrect + 1, documentLength);


//               //Navigator 1 (don't change)
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) => SpecificTopicsPage(
//                   generalTopicIndex: widget.generalTopicIndex, 
//                   appBarTitle: widget.appBarTitle, 
//                   user: widget.user,
//                   googleSignIn: widget.googleSignIn,
//                 )
//               ));





//             }
//             else {
//               //if not last question, push to next question with an passedInIndex increased by one; passedInIndex value will be used to retrieve document



//                 //Navigator 2
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => QuestionPage(
//                     generalTopicIndex: widget.generalTopicIndex, specificTopicIndex: widget.specificTopicIndex,
//                     passedInIndex: index + 1,
//                     appBarTitle: widget.appBarTitle,
//                     numberWrong: widget.numberWrong,
//                     numberCorrect: widget.numberCorrect + 1,
//                     user: widget.user,
//                     googleSignIn: widget.googleSignIn,
//                   ),
//                 ));
//               }
//             }
//           else {
//             //what happens if answer is inccorect
//             print("Answer is incorrect!");
//             if (index == documentLength - 1) {
//               //checks if you're on the last question
//               print("We're done here!");

//               _updateScores(widget.numberCorrect, documentLength);

//               //Navigator 3 (don't change)
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) => SpecificTopicsPage(
//                   generalTopicIndex: widget.generalTopicIndex, 
//                   appBarTitle: widget.appBarTitle,
//                   user: widget.user,
//                   googleSignIn: widget.googleSignIn,
//                 )
//               ));

              

//             }
//             else {
//               //if not last question, push to next question with an passedInIndex increased by one; passedInIndex value will be used to retrieve document


//                 //Navigator 4
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => QuestionPage(
//                     generalTopicIndex: widget.generalTopicIndex, specificTopicIndex: widget.specificTopicIndex,
//                     passedInIndex: index + 1,
//                     appBarTitle: widget.appBarTitle,
//                     numberCorrect: widget.numberCorrect,
//                     numberWrong: widget.numberWrong + 1,
//                     user: widget.user,
//                     googleSignIn: widget.googleSignIn,
//                   ),
//                 ));
//               }
//             }
//           },
        
        
//         child: Center(
//           child: Container(
//             decoration: BoxDecoration(
//               // color: optionColor,
//               border: Border.all(
//               ),
//               borderRadius: BorderRadius.circular(50.0)
//             ),
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 document['o' + '$optionNumber'],
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQuestionPage(BuildContext context, DocumentSnapshot document, int documentLength, int index) {

//     final double statusBarHeight = MediaQuery
//       .of(context)
//       .padding
//       .top;

//     final double barHeight = 66.0;

//     var _questionFontSize = 30.0;
//     List<String> _splitQuestion = document['title'].split(" ");
//     // print(_splitQuestion);
//     if (_splitQuestion.length > 5) {
//       _questionFontSize = 20.0;
//     }

      
//     return GestureDetector(
      
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             width: double.infinity,
//             height: 80.0,
//             color: Colors.orangeAccent,
//             child: 
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: Container(
//                           // alignment: FractionalOffset.centerRight,
//                           padding: EdgeInsets.only(left: 45.0),
//                           child: Center(
//                             child: Text(
//                                 "Question "
//                                 "${index + 1}" +
//                                 " of " +
//                                 "${documentLength.toString()}",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   // fontWeight: FontWeight.bold,
//                                   fontFamily: "viga",
                                  
//                                 ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: IconButton(
//             onPressed: () {
//               showDialog(
//                   context: context,
                  
//                   builder: (BuildContext context) =>
//                     AlertDialog(
//                       content: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0)
//                         ),
//                         height: 200.0,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Text(
//                                 "Are you sure you want to exit this quiz? Your progress and score will not be saved.",
//                                 style: TextStyle(
//                                   fontSize: 16.0
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             Divider(),
//                             Padding(padding: EdgeInsets.only(bottom: 10.0),),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: <Widget>[
//                                 InkWell(
//                                   onTap: (){
//                                       Navigator.push(context, MaterialPageRoute(
//                                         builder: (context) => SpecificTopicsPage(
//                                           generalTopicIndex: widget.generalTopicIndex, 
//                                           appBarTitle: widget.appBarTitle, 
//                                           user: widget.user,
//                                           googleSignIn: widget.googleSignIn,
//                                         )
//                                       ));
//                                     },
//                                   child: Container(
//                                     padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
//                                     child: Column(
//                                       children: <Widget>[
//                                         Icon(Icons.check, color: Colors.black,),
//                                         Padding(
//                                           padding: EdgeInsets.all(5.0),
//                                         ),
//                                         Text(
//                                           "Yes",
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
//                                     child: Column(
//                                       children: <Widget>[
//                                         Icon(Icons.close),
//                                         Padding(
//                                           padding: EdgeInsets.all(5.0),
//                                         ),
//                                         Text("Cancel"),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//               );
//             },
//             // alignment: Alignment.centerRight,
//             icon: Icon(FontAwesomeIcons.times, color: Colors.white,),
//         ),
  
//                       ),
//                     ],
//                   ),
//                 ),
//           ),

         
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.orange[300],
//               borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(15.0)
//               ),
//             ),
//             margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//             height: 70.0,
//             width: 280.0,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
//               child: Text(
//                 document['directions'],
//                 style: TextStyle(
//                   color: Colors.white
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ),
//           ),
          
          
              
//           Center(
//             child: Container(
//               margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 // color: Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(20.0),
//                  gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   colors: [
//                     Colors.amber[400],
//                     // Colors.amber[300]
//                     Colors.amber[500]
//                   ]
//                 ),
//               ),
//               child: Text(
//                 document['title'],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: _questionFontSize,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),          
//             ),
//           ),
//           _checkAndCreateAnswer(1, document, index, documentLength),
//           _checkAndCreateAnswer(2, document, index, documentLength),
//           _checkAndCreateAnswer(3, document, index, documentLength),
//           _checkAndCreateAnswer(4, document, index, documentLength),

//           // MaterialButton(
//           //   child: Text("ZZZZ UPDATE!!!"),
//           //   color: Colors.orange,
//           //   onPressed: _updateQuestions,
//           // ),

//           Container(
//             decoration: BoxDecoration(
//                gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 colors: [
//                   Colors.amber[500],
//                   Colors.amber[600]
//                 ]
//               ),
//               borderRadius: BorderRadius.horizontal(
//                 right: Radius.circular(15.0)
//               ),
//             ),
//             margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
//             height: 50.0,
//             width: 170.0,
//             child: Row(
//               children: <Widget>[
//                 //correct answers
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       colors: [
//                         Colors.green[400],
//                         Colors.green[500]
//                       ]
//                     ),
//                   ),
//                   margin: const EdgeInsets.only(left: 10.0),
//                   height: 20.0,
//                   width: 20.0,
//                 ),
//                 Container(
//                   child: Text(
//                     "  :  " + widget.numberCorrect.toString(),
//                     style: TextStyle(
//                       color: Colors.white
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//                 //incorrect answers
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20.0),
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       colors: [
//                         Colors.red[400],
//                         Colors.red[500]
//                       ]
//                     ),
//                   ),
//                   margin: const EdgeInsets.only(left: 40.0),
//                   height: 20.0,
//                   width: 20.0,
//                 ),
//                 Container(
//                   child: Text(
//                     "  :  " + widget.numberWrong.toString(),
//                     style: TextStyle(
//                       color: Colors.white
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//         ],
//       ),
//     );
//   }
// }



//           // GestureDetector(
//           //   onTap: () {
//           //   },
//           //   child: Container(
//           //     //padding: new EdgeInsets.only(top: statusBarHeight),
//           //     decoration: BoxDecoration(
//           //       color: Colors.blueAccent,
//           //       // borderRadius: BorderRadius.only(
//           //       //   bottomLeft: Radius.circular(10.0),
//           //       //   bottomRight: Radius.circular(10.0)
//           //       // ),
//           //     ),
              
//           //     width: double.infinity,
//           //     height: statusBarHeight + barHeight,
//           //     child: Row(
//           //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

//           //       children: <Widget>[
//           //         Container(
//           //           // margin: EdgeInsets.all(16.0),
//           //           // alignment: Alignment.center,
//           //           // margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 2, 0.0, 0.0, 0.0),
//           //           child: Text(
//           //             "Question "
//           //             "${index + 1}" +
//           //             " of " +
//           //             "${documentLength.toString()}",
//           //             textAlign: TextAlign.center,
//           //             style: TextStyle(
//           //               color: Colors.white,
//           //               // fontWeight: FontWeight.bold,
//           //               fontFamily: "viga"
//           //             ),

//           //           ),
//           //         ),
//           //         Text(
//           //           "Lengua",
//           //           style: TextStyle(
//           //             fontFamily: "viga",
//           //             color: Colors.white,
//           //             fontSize: 20.0
//           //           ),
//           //         ),
//           //           IconButton(
//           //             onPressed: () {
//           //               showDialog(
//           //                 context: context,
//           //                 builder: (BuildContext context) =>
//           //                   AlertDialog(
//           //                     content: Text("Are you sure you want to exit?"),
//           //                   ),
//           //               );
//           //             },
//           //             // alignment: Alignment.centerRight,
//           //             icon: Icon(Icons.cancel, color: Colors.white,),
//           //         ),
//           //       ],
//           //     ),
              
//           //   ),
//           // ),