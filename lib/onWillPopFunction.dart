import 'dart:async';

import 'package:Lengua/generalTopicsPage.dart';
import 'package:Lengua/specificTopicsPage.dart';
import 'package:flutter/material.dart';

Future<bool> exitApp(BuildContext context) {
  // return showDialog(
  //       context: context,
  //       builder: (BuildContext context) =>
  //         AlertDialog(
  //           content: Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20.0)
  //             ),
  //             height: 200.0,
  //             child: Column(
  //               children: <Widget>[
  //                 Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Text(
  //                     "Are you sure you want to exit this quiz? Your progress and score will not be saved.",
  //                     style: TextStyle(
  //                       fontSize: 16.0
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //                 Divider(),
  //                 Padding(padding: EdgeInsets.only(bottom: 10.0),),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: <Widget>[
  //                     InkWell(
  //                       onTap: (){
  //                           // Navigator.push(context, MaterialPageRoute(
  //                           //   builder: (context) => SpecificTopicsPage(
  //                           //     generalTopicIndex: widget.generalTopicIndex, 
  //                           //     appBarTitle: widget.appBarTitle, 
  //                           //     user: widget.user,
  //                           //     googleSignIn: widget.googleSignIn,
  //                           //   )
  //                           // ));
  //                         },
  //                       child: Container(
  //                         padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
  //                         child: Column(
  //                           children: <Widget>[
  //                             Icon(Icons.check, color: Colors.black,),
  //                             Padding(
  //                               padding: EdgeInsets.all(5.0),
  //                             ),
  //                             Text(
  //                               "Yes",
  //                               style: TextStyle(color: Colors.black),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     InkWell(
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Container(
  //                         padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
  //                         child: Column(
  //                           children: <Widget>[
  //                             Icon(Icons.close),
  //                             Padding(
  //                               padding: EdgeInsets.all(5.0),
  //                             ),
  //                             Text("Cancel"),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //     ) ??
  //     false;
}
