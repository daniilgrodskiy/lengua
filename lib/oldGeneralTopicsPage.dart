// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:spanish_grammar_app_flutter/generalTopicsPage.dart';
// import 'package:spanish_grammar_app_flutter/specificTopicsPage.dart';
// /*
//  * 
//  * Through my perilous journey, I've found 2 solutions that aren't PERFECT, BUT they shall do:
//  * 
//  * 1. Instead of using a SliverList, use a SliverFixedExtentList.
//  * 2. Instead of using a SliverList, use (and experiment with) a SliverFilllRemaining
//  * 
//  * 
//  * 
//  * 3. SliverFillViewport was a little weird and didn't work.
//  * 4. SliverOverlapAbsober - No luck
//  * 5. SliverOverlapInjector - No luck
//  * 6. SliverMultiBoxAdaptorElement - No luck
//  * 7. SliverMultiBoxAdaptorWidget - No luck
//  * */

// // SliverPadding(
// //             //This is where it doesn't work as intended. Its behavior is separate from the containers located above and below it because it suddenly includes a StreamBuilder.
// //             padding: EdgeInsets.all(16.0),
// //             sliver:  SliverFixedExtentList(
// //               itemExtent: 400.0,
// //                 delegate:  
// //                 SliverChildBuilderDelegate(
// //                   (BuildContext context, int index) {
// //                   return StreamBuilder(
// //                     stream: Firestore.instance.collection("content").snapshots(),
// //                     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //                       if (!snapshot.hasData) {
// //                         return Container(
// //                           child: Center(
// //                             child: CircularProgressIndicator(),
// //                           ),
// //                         );
// //                       } else {
// //                         return Container(
// //                           margin: EdgeInsets.all(20.0),
// //                           color: Colors.green,
// //                           height: 400.0,
// //                           child: Center(
// //                             child: Text(
// //                               snapshot.data.documents[0]['title'],
// //                               style: TextStyle(
// //                                 color: Colors.white
// //                               ),
// //                               textAlign: TextAlign.center,
// //                             ),
// //                           ),
// //                         );
// //                       }
// //                     },
// //                   );
// //                 },
// //                 childCount: 8,
// //               ),
// //           ),
          
// //         ),

// //    SliverPadding(
//         //     //This is where it doesn't work as intended. Its behavior is separate from the containers located above and below it because it suddenly includes a StreamBuilder.
//         //     padding: EdgeInsets.all(16.0),
//         //     sliver: SliverFillRemaining(
//         //         child:  StreamBuilder(
//         //           stream: Firestore.instance.collection("content").snapshots(),
//         //           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         //             if (!snapshot.hasData) {
//         //               return Container(
//         //                 child: Center(
//         //                   child: CircularProgressIndicator(),
//         //                 ),
//         //               );
//         //             } else {
//         //               // print("Snapshot refreshing...");
//         //               return ListView.builder(
//         //                 itemCount: snapshot.data.documents.length,
//         //                 itemBuilder: (BuildContext context, int index) {
//         //                   return Container(
//         //                     margin: EdgeInsets.all(20.0),
//         //                     color: Colors.green,
//         //                     height: 400.0,
//         //                     child: Center(
//         //                       child: Text(
//         //                         snapshot.data.documents[index]['title'],
//         //                         style: TextStyle(
//         //                           color: Colors.white
//         //                         ),
//         //                         textAlign: TextAlign.center,
//         //                       ),
//         //                     ),
//         //                   ); 
//         //                 },
//         //               );
//         //               // return Container(
//         //               //   margin: EdgeInsets.all(20.0),
//         //               //   color: Colors.green,
//         //               //   height: 400.0,
//         //               //   child: Center(
//         //               //     child: Text(
//         //               //       snapshot.data.documents[0]['title'],
//         //               //       style: TextStyle(
//         //               //         color: Colors.white
//         //               //       ),
//         //               //       textAlign: TextAlign.center,
//         //               //     ),
//         //               //   ),
//         //               // );
//         //             }
//         //       },
//         //     ),
//         //   ),
//         // ),

// class GeneralTopicsPage extends StatefulWidget {

//   GeneralTopicsPage({this.user, this.googleSignIn, this.index});

//   final FirebaseUser user;
//   final GoogleSignIn googleSignIn;
//   var index;

//   @override
//   _GeneralTopicsPageState createState() => new _GeneralTopicsPageState();
// }

// class CrazyWidgetBuildTest extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       child: Text("Hey"),
//     );
//   }
// }

// class _GeneralTopicsPageState extends State<GeneralTopicsPage> {

// var testList = ["Adjectives2", "Adverbs2", "Conjunction2", "Prepositions2", "Verbs2", "Testing2", "Testing", "Testing", "Testing", "Testing"];

// var documentLength = 20;

// // _getStreamDocuments() {
// //   Firestore.instance.collection("content").snapshots().listen((snapshot){
// //           var documentLength = snapshot.documents.length - 1;
// //           print("Testing $documentLength");
// //       });
// //       return int.parse(documentLength.toString();
// // }
// // var testing = Firestore.instance.collection("content").snapshots().listen((snapshot){
// //   snapshot.documents.length;
// // });

//   @override
//     void initState() {
//       // TODO: implement initState
//       super.initState();
//       // Firestore.instance.collection("content").snapshots().listen((snapshot){
//       //     documentLength = snapshot.documents.length - 1;
//       //     print("Testing $documentLength");
//       // });
//     }
  
//   @override
//   Widget build(BuildContext context) {


//     return Scaffold(
//       body:  new Column(
//           children: <Widget> [
//             Text("Your Card List"),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//           stream: Firestore.instance.collection('content').snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) return const Text('Connecting...');
//               final int cardLength = snapshot.data.documents.length;
//               final DocumentSnapshot _card = snapshot.data.documents[0];
//               return new ListView(
//                 children: <Widget>[
//                   // Container(
//                   //   margin: EdgeInsets.all(20.0),
//                   //   color: Colors.green,
//                   //   height: 200.0,
//                   //   child: Text("Hey what's up"),
//                   // ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.all(20.0),
//                       color: Colors.green,
//                       height: 200.0,
//                       child: Text(_card['title']),
//                     ),
//                   ),
//                 //   Expanded(
//                 //     child: ListView.builder(
//                 //        itemCount: cardLength,
//                 // itemBuilder: (BuildContext context, int index) {
//                 //     final DocumentSnapshot _card= snapshot.data.documents[index];
//                 //     return new ListTile(
//                 //       title: new Text(_card['title']),
//                 //       // subtitle: new Text(_card['description']),
//                 //     );
//                 // },
//                 //     ),
//                 //   )
//                 ],
//                 // itemCount: cardLength,
//                 // itemBuilder: (BuildContext context, int index) {
//                 //   final DocumentSnapshot _card= snapshot.data.documents[index];
//                 //   return new ListTile(
//                 //     title: new Text(_card['title']),
//                 //     // subtitle: new Text(_card['description']),
//                 //   );
//                 // },
//               );
//           },
//               ),
//             ),
//         ],
//         ),
//         );
// //       body: CustomScrollView(
// //         slivers: <Widget>[
// //           SliverAppBar(
// //             pinned: true,
// //             //MAYBE CHANGE PINNED TO 'false'????
// //             //IF SO, ADD A STATUS BAR CONTAINER WITH A COLOR TO THE TOP
// //             title: Text(
// //               "Lengua",
// //               style: TextStyle(
// //                 fontFamily: "viga",
// //               ),
// //             ),
// //           ),
// //           SliverPadding(
// //             padding: EdgeInsets.all(16.0),
// //             sliver: SliverList(
// //               // itemExtent: 1.0,
// //             delegate: SliverChildBuilderDelegate(
// //               (BuildContext context, int index) {
// //                 // _getStreamDocuments();
// //                 print(documentLength);
// //                   return Text("Testing");
// //               },
// //               childCount: 1
// //             ),
// //             ),
// //           ),
// //            SliverPadding(
// //             padding: EdgeInsets.all(16.0),
// //             sliver: SliverList(
// //             // itemExtent: 20.0,
            
            
            
// //             delegate: SliverChildBuilderDelegate(
              
// //               (BuildContext context, int index) {
                
// //                 // _getStreamDocuments();
// //                 print(testList[0]);
// //                   // return Container(
// //                   //   margin: EdgeInsets.all(40.0),
// //                   //   padding: EdgeInsets.all(40.0),
// //                   //   height: 300.0,
// //                   //   color: Colors.green,
// //                   //   child: Text(
// //                   //     testList[index],
// //                   //   )
// //                   // );

// //                   /*
// //                   *
// //                   * Look at difference between normal container and why that works and why a StreamBuilder does not.
// //                   *
// //                    */

// //                     return  StreamBuilder(
// //                       stream: Firestore.instance.collection("content").snapshots(),
// //                       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //                         if (!snapshot.hasData) {
// //                           return Container(
// //                             child: Center(
// //                               child: CircularProgressIndicator(),
// //                             ),
// //                           );
// //                         } else {
// //                           // if (index < 5){
// //                           // return Container(
// //                           //   margin: EdgeInsets.all(40.0),
// //                           //   padding: EdgeInsets.all(40.0),
// //                           //   height: 60.0,
// //                           //   color: Colors.green,
// //                           //   child: Text(
// //                           //     snapshot.data.documents[index]['title']),
// //                           // );
// //                           return Container(
// //                             child: Text(snapshot.data.documents[index]['title']),
// //                             height: 400.0,
// //                           );
// // //  return _buildGeneralItems(context, snapshot.data.documents[index], index);
// //                           // }
// //                           // else {
// //                           //   return Text("We outtie");
// //                           // }
// //                         }
                        
// //                       },
// //                     );
// //                   },
// //                   childCount: 6,
// //                   addAutomaticKeepAlives: false,
// //                   // addRepaintBoundaries: false,
              
// //             ),
            
// //             ),
            
// //           ),
// //           // SliverPadding(
// //           //   padding: EdgeInsets.all(16.0),
// //           //   sliver: SliverList(
// //           //     // itemExtent: 1.0,
// //           //     delegate: SliverChildBuilderDelegate(
// //           //       (BuildContext context, int index) {
// //           //         if (index == 0) {
// //           //           _getDocumentLengthThroughStreamBuilder();
// //           //         }
// //           //       }
// //           //     ),
// //           //   ),
// //           // ),
// //           // SliverPadding(
// //           //   padding: EdgeInsets.all(16.0),
// //           //   sliver: SliverList(
// //           //     // itemExtent: 10.0,
// //           //     delegate: SliverChildBuilderDelegate(
// //           //       (BuildContext context, int index) {

// //           //         // if (index < documentLength){
// //           //           /**********  
// //           //            * 
// //           //            * I need to somehow make the "documentLength" a specific value that honestly gets documents.length outside of this build function. I want it to 100% of the time work with no errors and without having to make empty Containers or have a predefined value of "100" or "20".
// //           //            * 
// //           //            * 
// //           //           **********/
// //           //           print("Got in here with a function value of $documentLength");
                    
// //           //           // print(documentLength.toString());

// //           //           return  StreamBuilder(
// //           //             stream: Firestore.instance.collection("content").snapshots(),
// //           //             builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           //               if (!snapshot.hasData) {
// //           //                 return Container(
// //           //                   child: Center(
// //           //                     child: CircularProgressIndicator(),
// //           //                   ),
// //           //                 );
// //           //               } else {

// //           //                 if (index < snapshot.data.documents.length){
// //           //                   documentLength = snapshot.data.documents.length;
// //           //                   return _buildGeneralItems(context, snapshot.data.documents[index], index);
// //           //                 }
// //           //                 // return Text("Shouldn't be here");
// //           //                 return Container(
// //           //                   color: Colors.white,
// //           //                   padding: EdgeInsets.all(0.0),
// //           //                   margin: EdgeInsets.all(0.0),
// //           //                   height: 0.0,
// //           //                   width: 0.0,
// //           //                 );
// //           //               }
                        
// //           //             },
// //           //           );
// //           //         // }
// //           //       }
// //           //     ),
// //           //   ),
// //           // )
// //         ],
// //       ),
//     // );

//   }


//  _getDocumentLengthThroughStreamBuilder() {
//     return StreamBuilder(
//       stream: Firestore.instance.collection("content").snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return Container(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else {
//           documentLength = snapshot.data.documents.length;
//           print("The document length has been updated with a value of $documentLength");
//           return Text("This is giving me the document length");
//           // return Container(
//           //   height: 0.0,
//           //   width: 0.0,
//           // );
//         }
//       }
//     );
//   }

//   Widget _buildGeneralItems(BuildContext context, DocumentSnapshot document, int index) {
    

//     // var hero = new Hero(
//     //   tag: 'hero-tag-transition-title',
//     //   child: transitionTitle,
//     // );

//     // var _heroChild = Container(
//     //   height: 50.0,
//     //   width: double.infinity,
//     //   child: hero,
//     // );

//     // var decoratedBox = DecoratedBox(
//     //   decoration: BoxDecoration(
//     //     image: DecorationImage(
//     //       fit: BoxFit.fitWidth,
//     //       image: AssetImage("assets/wallpaper.jpg")
//     //     )
//     //   ),
//     // );

//     // var hero = Hero(
//     //   tag: "hero-tag-test",
//     //   child: decoratedBox,
//     // );


//     // var _heroChild = Container(
//     //   height: 50.0,
//     //   width: 50.0,
//     //   child: hero,
//     // );


//     // if (index == 0) {
//     //   return Column(
//     //     children: <Widget>[
//     //       Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Container(
//     //           child: Text("Select a general topic:"),
//     //         ),
//     //       ),
//     //     ],
//     //   );
//     // }




//     return GestureDetector(
      
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) => SpecificTopicsPage(generalTopicIndex: document.documentID, appBarTitle: document['title'].toString(),)
//         ));
//       },

      
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.deepPurple[200],
//           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//           boxShadow: [BoxShadow(
//             color: Colors.black26,
//             blurRadius: 20.0,
//             spreadRadius: 3.0
            
//           ),]
//         ),
//         padding: EdgeInsets.all(5.0),
//         margin: EdgeInsets.all(10.0),
//         height: 300.0,
//         child: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               //mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // _heroChild,
//                 Padding(
//                   padding: const EdgeInsets.only(top: 50.0),
//                   child: Text(
//                     document['title'],
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       // fontFamily: "helvetica",
//                       height: 1.1,
//                       color: Colors.white,
//                       //originally Colors.white
//                       fontSize: 40.0
//                     ),
//                   ),
//                 ),
//                 // Container(
//                 //   child: Icon(Icons.keyboard_arrow_right)
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//       // return new Scaffold(
//     //   appBar: AppBar(
//     //     title: Text(
//     //       "Lengua",
//     //       style: TextStyle(
//     //         // fontWeight: FontWeight.bold,
//     //         fontFamily: "viga",
//     //       ),
//     //     ),
//     //   ),
//   //     return Scaffold(
//   //        appBar: AppBar(
//   //       title: Text(
//   //         "Lengua",
//   //         style: TextStyle(
//   //           // fontWeight: FontWeight.bold,
//   //           fontFamily: "viga",
//   //         ),
//   //       ),
//   //     ),
//   //       body: Container(
//   //         child: StreamBuilder(
//   //           stream: Firestore.instance.collection("content").snapshots(),
//   //           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//   //             if (!snapshot.hasData) {
//   //               return Container(
//   //                 child: Center(
//   //                   child: CircularProgressIndicator(),
//   //                 ),
//   //               );
//   //             } else {
//   //               //print(snapshot.data.documents);
//   //               return ListView.builder(
//   //                 scrollDirection: Axis.vertical,
//   //                 // itemExtent: 10.0,
//   //                 //^ THIS IS WHAT SCREWED UP THE ListTile SIZES!!!
//   //                 itemCount: snapshot.data.documents.length,
//   //                 itemBuilder: (BuildContext context, int index) =>
//   //                   _buildGeneralItems(context, snapshot.data.documents[index], index)
//   //               );
//   //               //return FirestoreListView(documents: snapshot.data.documents);
//   //             }
              
//   //           },
//   //         ),
//   //       ),
//   //     );
//   // }


// // class StreamBuilderTest extends StatelessWidget {

// //   @override
// //   Widget build(BuildContext context) {
// //     return new Container(
      
// //     );
// //   }
// }

// // class GeneralTopicsList extends StatelessWidget {

// //   GeneralTopicsList({this.documents});

// //   // final BuildContext context;
// //   final List<DocumentSnapshot> documents;
// //   // final index;

// //   @override
// //   Widget build(BuildContext context) {
    
// //       return ListView.builder(
// //         itemCount: documents.length,
// //         itemExtent: 90.0,
// //         itemBuilder: (BuildContext context, int index) {
// //           String title = documents[index].data['title'];

// //           return GestureDetector(

// //         onTap: (){
// //             // Navigator.push(context,
// //             //   MaterialPageRoute(
// //             //     builder: (context) => new DetailScreen(photo: list[index])));
// //             //     //builder: (BuildContext context) => new PageTwo()));            
// //           },
        
// //         child: Container(
// //           decoration: BoxDecoration(
// //             color: Colors.deepPurple[200],
// //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
// //             boxShadow: [BoxShadow(
// //             color: Colors.black38,
// //             blurRadius: 10.0,
// //             spreadRadius: 5.0
// //             ),]
// //           ),
// //           padding: EdgeInsets.all(5.0),
// //           margin: EdgeInsets.all(10.0),
// //           height: 400.0,

// //             child: Padding(
// //             padding: EdgeInsets.all(10.0),
// //             child: Container(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: <Widget>[
// //                   Text(
// //                     documents[index].data['title'],
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontFamily: "helvetica",
// //                       height: 1.1,
// //                       color: Colors.white,
// //                       //originally Colors.white
// //                       fontSize: 40.0)
// //                   ),

// //                 ],
// //               ),
// //             ),
// //             ),
// //           ),
            
// //               );
// //         }
// //         );
// //         }
  
// // }

// /////////
// ///SPECFICS TOPICS PAGE
// /////
// /////
// ///
// ///
// ///
// ///
// ///
// ///
// ///
// ///
// ///
// ///import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:spanish_grammar_app_flutter/generalTopicsPage.dart';
// // import 'package:spanish_grammar_app_flutter/questionPage.dart';

// // class SpecificTopicsPage extends StatefulWidget {

// //   final generalTopicIndex;
// //   final appBarTitle;
// //   //appBarTitle currently doesn't work

// //   SpecificTopicsPage({this.generalTopicIndex, this.appBarTitle});


// //   @override
// //   _SpecificTopicsPageState createState() => new _SpecificTopicsPageState();
// // }

// // class _SpecificTopicsPageState extends State<SpecificTopicsPage> {

  
// //   @override
// //     void initState() {
// //       super.initState();
// //     }
  
// //   @override
// //   Widget build(BuildContext context) {

// //     return new Scaffold(
// //       appBar: AppBar(
// //         // title: Text(widget.appBarTitle.toString()),
// //         title: Text(
// //           "Lengua",
// //           style: TextStyle(
// //             // fontWeight: FontWeight.bold,
// //             fontFamily: "viga",
// //           ),
// //         ),
// //       ),
// //       body: Container(
// //         child: StreamBuilder(
// //           stream: Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics").snapshots(),
// //           builder: (BuildContext context, 
// //           AsyncSnapshot<QuerySnapshot> snapshot) {
// //             if (!snapshot.hasData) {
// //               return Container(
// //                 child: Center(
// //                   child: CircularProgressIndicator(),
// //                 ),
// //               );
// //             } else {
// //               return ListView.builder(
// //                 scrollDirection: Axis.vertical,
// //                 // itemExtent: 10.0,
// //                 itemCount: snapshot.data.documents.length,
// //                 itemBuilder: (BuildContext context, int index) =>
// //                   _buildSpecificItems(context, snapshot.data.documents[index], index)
// //               );
// //               //return FirestoreListView(documents: snapshot.data.documents);
// //             }
            
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildSpecificItems(BuildContext context, DocumentSnapshot document, int index) {

// //     print(widget.appBarTitle);

// //     // var transitionTitle = Text(
// //     //   widget.appBarTitle,
// //     //   style: TextStyle(
// //     //     fontWeight: FontWeight.bold,
// //     //     fontFamily: "helvetica",
// //     //     height: 1.1,
// //     //     color: Colors.white,
// //     //     //originally Colors.white
// //     //     fontSize: 40.0
// //     //   ),
// //     // );

// //     // var hero = new Hero(
// //     //   tag: 'hero-tag-transition-title',
// //     //   child: transitionTitle,
// //     // );

// //     // var _heroChild = Container(
// //     //   decoration: BoxDecoration(
// //     //     color: Colors.purple
// //     //   ),
// //     //   height: 50.0,
// //     //   width: double.infinity,
// //     //   child: hero,
// //     // );

// //     var decoratedBox = DecoratedBox(
// //       decoration: BoxDecoration(
// //         image: DecorationImage(
// //           fit: BoxFit.fitWidth,
// //           image: AssetImage("assets/wallpaper.jpg")
// //         )
// //       ),
// //     );

// //     var hero = Hero(
// //       tag: "hero-tag-test",
// //       child: decoratedBox,
// //     );


// //     var _heroChild = Container(
// //       height: 100.0,
// //       width: 100.0,
// //       child: hero,
// //     );

// //     // if (index == 0) {
// //     //   return Padding(
// //     //     padding: const EdgeInsets.all(8.0),
// //     //     child: Column(
// //     //       children: <Widget>[
// //     //         Container(
// //     //           child: Text("Select a specific topic:"),
// //     //         ),
// //     //         // Container(child: _heroChild,)
// //     //       ],
// //     //     ),
// //     //   );
// //     // }

      
// //     return GestureDetector(
// //       onTap: (){
// //         Navigator.push(context, MaterialPageRoute(
// //           builder: (context) => QuestionPage(generalTopicIndex: widget.generalTopicIndex, appBarTitle: document['title'].toString(), specificTopicIndex: document.documentID, passedInIndex: 0, )
// //         ));
// //       },
      
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: Colors.deepPurple[200],
// //           borderRadius: BorderRadius.all(Radius.circular(15.0)),
// //           boxShadow: [BoxShadow(
// //             color: Colors.black26,
// //             blurRadius: 20.0,
// //             spreadRadius: 3.0
// //           ),]
// //         ),
// //         padding: EdgeInsets.all(5.0),
// //         margin: EdgeInsets.all(10.0),
// //         height: 200.0,
// //           child: Padding(
// //             padding: EdgeInsets.all(10.0),
// //             child: Container(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: <Widget>[
// //                   Container(
// //                     alignment: Alignment.bottomRight,
// //                     // child: _heroChild
// //                   ),
// //                   Text(
// //                     document['title'],
// //                     style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontFamily: "helvetica",
// //                       height: 1.1,
// //                       color: Colors.white,
// //                       //originally Colors.white
// //                       fontSize: 40.0
// //                     ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }