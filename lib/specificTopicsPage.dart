import 'dart:async';
import 'package:Lengua/onWillPopFunction.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'generalTopicsPage.dart';
import 'questionPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:layout_demo_flutter/layout_type.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'main.dart';

class SpecificTopicsPage extends StatefulWidget {

  final generalTopicIndex;
  final appBarTitle;
  final FirebaseUser user;
  final GoogleSignIn googleSignIn;
  //appBarTitle currently doesn't work

  SpecificTopicsPage({this.generalTopicIndex, this.appBarTitle, this.user, this.googleSignIn});


  @override
  _SpecificTopicsPageState createState() => new _SpecificTopicsPageState();
}

class _SpecificTopicsPageState extends State<SpecificTopicsPage> {

_SpecificTopicsPageState({
    Key key, 
    // this.layoutGroup,
    this.onLayoutToggle
  });

  // final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;

  int pageLength;
  var documentTitle;
  StreamSubscription<QuerySnapshot> subscription;
  StreamSubscription<QuerySnapshot> questionSubscription;
  // StreamSubscription<QuerySnapshot> scoreSubscription;
  StreamSubscription<DocumentSnapshot> scoreSubscription;

  var mapOfScoreKeys;



  String getDocumentTitle() {
    print(widget.appBarTitle);
    return widget.appBarTitle;
  }


  void initState() {
    super.initState();

    subscription = Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics").snapshots().listen((snapshot) {
      setState(() {
        pageLength = snapshot.documents.length;
        
        // print(pageLength);
      });
    });

    // questionSubscription = Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics/" + widget.specificTopicIndex + "/questions").snapshots().listen((snapshot) {
    //   setState(() {
    //     pageLength = snapshot.documents.length;
        
    //     print(pageLength);
    //   });
    // });


    scoreSubscription = Firestore.instance.document("userScores/" + widget.user.email).snapshots().listen((snapshot) {
      setState(() {
        // print(snapshot.documents[0].data.keys.toList().toString() + "This is it");
        // print(snapshot.documents[0].data.values.toList().toString() + "This is it");

        // mapOfScoreKeys = snapshot.documents[0].data;

        mapOfScoreKeys = snapshot.data;

        
        
        print(mapOfScoreKeys);
        //maybe convert .toList
      });
    });

    // scoreSubscription = Firestore.instance.collection("userScores").where("user", isEqualTo: widget.user.email).snapshots().listen((snapshot) {
    //   setState(() {
    //     // print(snapshot.documents[0].data.keys.toList().toString() + "This is it");
    //     // print(snapshot.documents[0].data.values.toList().toString() + "This is it");

    //     mapOfScoreKeys = snapshot.documents[0].data;
        
        
    //     // print(mapOfScoreKeys);
    //     //maybe convert .toList
    //   });
    // });


    //we need to create an entry for 
    //get all of the properties and numbers associated (key-value pairs) and put them in an array
    //find widget.user first, and then check if document.documentID == key, then value will become the high score

  }

  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {



    _createSliderOptions(text, isHighlighted) {
      
      var borderColor = Color(0xFF000000);

      if (isHighlighted){
        borderColor = Colors.greenAccent;
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 5.0, 5.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0
                ),
              ),
            ),
          ),
        ),
      );
    }

    _slidersAlertDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
          AlertDialog(
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0)
              ),
              height: 300.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Sort topics...",
                      style: TextStyle(
                        fontSize: 30.0
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(),
                  _createSliderOptions("Alphabetically", true),
                  _createSliderOptions("By Difficulty", false),
                  _createSliderOptions("By Completion", false),
                ],
              ),
            ),
          ),
        );
    }

    var titleBoxHeader = Container(
      width: double.infinity, 
      height: 300.0,
      child: Scaffold(
        body: Container(
          alignment: Alignment.bottomLeft,
          width: double.infinity,
          height: 300.0,
          // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple[100],
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.appBarTitle,
                style: TextStyle(
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );


      var hero = Hero(
        tag: "hero-tag-test",
        child: titleBoxHeader,
      );


      var _heroChild = Container(
        height: 350.0,
        width: double.infinity,
        child: hero,
      );

    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[

            // SliverPersistentHeader(
            //   delegate: HeroHeader(
            //     onLayoutToggle: onLayoutToggle,
            //     minExtent: 150.0,
            //     maxExtent: 250.0,
                
            //   ),
            // ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.orangeAccent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  // Navigator.(context, ModalRoute.withName("/loginPage"));
                  // Navigator.popUntil(context, ModalRoute.withName('/generalTopicsPage'));
                  Navigator.push(context, MaterialPageRoute(
                    //make sure that if you go back got popping//pushing with a route, that you give it the necessary parameters!!! function might break bc widget.user.email might call on null do to calling GeneralTopicsPage without having the 'user' property filled in
                    builder: (context) => GeneralTopicsPage(
                      user: widget.user,
                      googleSignIn: widget.googleSignIn,
                    ),
                  ));
                },
              ),
              pinned: true,
              // expandedHeight: 300.0,
              // floating: true,
              // snap: false,
              // flexibleSpace: Padding(
              //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              //   child: titleBoxHeader,
              // ),
              title: Text(
                widget.appBarTitle.toString(),
                style: TextStyle(
                  fontFamily: "viga"
                ),
              ),
            ),
            //   expandedHeight: 200.0,
            //   bottom: PreferredSize(
            //     preferredSize: new Size.fromHeight(200.0),
            //     child: Container(
            //       // child: Text(
            //       //   widget.generalTopicIndex.toString(),
            //       // ),
            //     ),
            //   )
            // ),
            // SliverPadding(
            //   padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
            //   sliver: SliverList(
            //     delegate: SliverChildBuilderDelegate(
            //       (BuildContext context, int index) {
            //         return titleBoxHeader;
            //       },
            //       childCount: 1,
            //     ),
            //   ),
            // ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[300],
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15.0)
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
                          height: 70.0,
                          width: 280.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Please select a specific topic and whether you want to see the article or quiz.",
                              style: TextStyle(
                                color: Colors.white
                              ),
                              textAlign: TextAlign.start,
                              
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _slidersAlertDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Colors.amber[800],
                                    // Colors.amber[300]
                                    Colors.amber[900]
                                  ]
                                ),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(15.0)
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20.0),
                              height: 70.0,
                              child: Center(child:
                                Icon(
                                  FontAwesomeIcons.slidersH,
                                  color: Colors.white,
                                ),
                                // IconButton(
                                //   icon: Icon(FontAwesomeIcons.slidersH),
                                //   color: Colors.white,
                                //   onPressed: () {
                                //     _slidersAlertDialog();
                                //   },
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  
                  },
                  childCount: 1,
                ),
              ),
            ),
            
            SliverPadding(
              padding: EdgeInsets.all(16.0),
              sliver: SliverFixedExtentList(
                itemExtent: 460.0,
                  delegate:  SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                    return StreamBuilder(
                      stream: Firestore.instance.collection("content/" + widget.generalTopicIndex + "/specificTopics").snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return _buildSpecificItems(context, snapshot.data.documents[index], index);
                        }
                      },
                    );
                  },
                  childCount: pageLength
                  /**
                   * TODO:
                   * childCount needs to be a value based on snapshot.data.documents.length from the collection "content". This will basically be the number of documents inside of "content".
                   * 
                   * **/
                ),
              ),
            ),
          ],
        ),
      ),
    );
  
}

  

  Widget _buildSpecificItems(BuildContext context, DocumentSnapshot document, int index) {

    String highScore = "N/A";
    

    if (mapOfScoreKeys != null) {
      // print(mapOfScoreKeys.toString() + " this is my moment");
      if (mapOfScoreKeys[document.documentID] != null)  {
        // print(mapOfScoreKeys[document.documentID]);
        var newScore = mapOfScoreKeys[document.documentID].toString();
        highScore = newScore;
      }
    }

  
    return GestureDetector(
      
       onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => QuestionPage(
            generalTopicIndex: widget.generalTopicIndex,
            appBarTitle: widget.appBarTitle, 
            specificTopicIndex: document.documentID,
            passedInIndex: 0,
            numberCorrect: 0,
            numberWrong: 0,
            user: widget.user,
            googleSignIn: widget.googleSignIn,
          )
        ));
      },

      child: Container(
        decoration: BoxDecoration(
           gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.yellow[700],
              // Colors.amber[300]
              Colors.yellow[800]
            ]
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [BoxShadow(
            color: Colors.black26,
            blurRadius: 20.0,
            spreadRadius: 3.0
          ),]
        ),

        margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        height: 300.0,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                child: Text(
                  document['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration:  BoxDecoration(
                       gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.amber[200],
                          Colors.amber[300], 
                        ]
                      ),
                      //PUT A BIT OF TRANSPARENCY SO THAT YOU CAN SEE THE BACKGROUND GO THROUGH A BIT!!!
                      borderRadius: BorderRadius.circular(30.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     spreadRadius: 10.0,
                      //     offset: Offset(0.0, 5.0),
                      //     blurRadius: 20.0
                      //   ),
                      // ],
                    ),
                    margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    child: Column(
                      children: <Widget>[
                        // Icon(Icons.keyboard_arrow_right),
                        Container(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                          child: Text(
                            "Article",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            FontAwesomeIcons.newspaper,
                            size: 40.0,
                          ),
                        )
                      ],
                    ),
                    height: 120.0,
                    width: 100.0,
                    
                  ),
                  Container(
                    decoration:  BoxDecoration(
                       gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.amber[300],
                          Colors.amber[500], 
                        ]
                      ),
                      //PUT A BIT OF TRANSPARENCY SO THAT YOU CAN SEE THE BACKGROUND GO THROUGH A BIT!!!
                      borderRadius: BorderRadius.circular(100.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black12,
                      //     spreadRadius: 10.0,
                      //     offset: Offset(0.0, 5.0),
                      //     blurRadius: 20.0
                      //   ),
                      // ],
                    ),
                    margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    child: Column(
                      children: <Widget>[
                        // Icon(Icons.keyboard_arrow_right),
                        Container(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                          child: Text(
                            "Quiz",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                          child: Divider(),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            FontAwesomeIcons.pencilAlt,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    height: 120.0,
                    width: 120.0,
                    
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
                height: 120.0,
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),
                          child: Text(
                            "High Score: "
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Text(
                            highScore.toString(),
                            // + document.data.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0
                            ),
                          ),
                        ),
                      ],
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: Divider(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: Colors.white
                      ),
                      height: 80.0,
                      width: 80.0,
                      margin: EdgeInsets.all(10.0)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}




class HeroHeader extends SpecificTopicsPage implements SliverPersistentHeaderDelegate{
  HeroHeader({
    // this.layoutGroup,
    this.onLayoutToggle,
    this.minExtent,
    this.maxExtent,
  });
  // final LayoutGroup layoutGroup;
  final VoidCallback onLayoutToggle;
  double maxExtent;
  double minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/test_background.png',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 4.0,
          top: 4.0,
          child: SafeArea(
            child: IconButton(
              // icon: Icon(layoutGroup == LayoutGroup.nonScrollable
              //     ? Icons.filter_1
              //     : Icons.filter_2),
              color: Colors.white,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            "Adjectives",
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}

