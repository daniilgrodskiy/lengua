import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'specificTopicsPage.dart';
import 'main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class GeneralTopicsPage extends StatefulWidget {

  GeneralTopicsPage({this.user, this.googleSignIn});

  final FirebaseUser user;
  final GoogleSignIn googleSignIn;

  @override
  _GeneralTopicsPageState createState() => new _GeneralTopicsPageState();
}

class _GeneralTopicsPageState extends State<GeneralTopicsPage> {


  int pageLength;
  StreamSubscription<QuerySnapshot> subscription;


  void initState() {
    super.initState();
    subscription = Firestore.instance.collection("content").snapshots().listen((snapshot) {
      setState(() {
        pageLength = snapshot.documents.length;
        // print(pageLength);
      });
    });
  }

  void dispose() {
    super.dispose();
    subscription?.cancel();
  }


  @override
  Widget build(BuildContext context) {



     var decoratedBox = DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/wallpaper.jpg")
          )
        ),
        child: Scaffold(
          body: Text("HEy What's up!!"),
        ),
      );
      //MAKE THE IMAGE A stream query!!!!! RATHER CREATE A VARIABLE UP THERE THAT GETS ALL THE PICTURES??? idk MAYBE MAKE A SECOND STREAM?? idk

      var hero = Hero(
        tag: "hero-tag-test",
        child: decoratedBox,
      );


      var _heroChild = Container(
        height: 10.0,
        width: 10.0,
        child: hero,
      );


    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        
      ),
      height: double.infinity,
      width: double.infinity,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.orangeAccent,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.popAndPushNamed(context, "/loginPage");
                },
              ),
              pinned: true,
              title: Text(
                "Lengua",
                style: TextStyle(
                  fontFamily: "viga"
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0.0, 20.0, 150.0, 5.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        // color: Color(0xFFffb142),
                        color: Colors.orange[300],
                      ),
                      padding: EdgeInsets.fromLTRB(0.0, 30.0, 20.0, 5.0),
                      height: 70.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Please select a general topic.",
                          style: TextStyle(
                            color: Colors.white
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16.0),
              sliver: SliverFixedExtentList(
                itemExtent: 350.0,
                  delegate:  SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                    return StreamBuilder(
                      stream: Firestore.instance.collection("content").snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return _buildGeneralItems(context, snapshot.data.documents[index], index, snapshot);
                        }
                      },
                    );
                  },
                  childCount: pageLength,
                  /**
                   * 
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

    
var numberOfDocuments = 0;


Widget _buildGeneralItems(BuildContext context, DocumentSnapshot document, int index, AsyncSnapshot<QuerySnapshot> snapshot) {

    // print(widget.user.email);


  var title = document['title'];
  var icon = ("FontAwesomeIcons." + document['icon']);
  // var correctIcon = Icon(icon.value);

  //process to convert and get color from string to casting it as Color()
  String colorString = document['color']; // Color(0x12345678)
  // print(colorString);
  String valueColorString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
  int valueColor = int.parse(valueColorString, radix: 16);
  Color color = new Color(valueColor);


  //process to convert and get icon from string to casting it as Icon()
  String iconString = document['color']; // Color(0x12345678)
  // print(iconString);
  String valueIconString = iconString.split('(0x')[1].split(')')[0]; // kind of hacky...
  int valueIcon = int.parse(valueIconString, radix: 16);
  Color correctIcon = new Color(valueIcon);
  






  var background = document['background'];


  
    return GestureDetector(
      
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => SpecificTopicsPage(
            generalTopicIndex: document.documentID, 
            appBarTitle: document['title'].toString(),
            user: widget.user,
            googleSignIn: widget.googleSignIn,
          ),
        ));
      },

      child: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: NetworkImage(document['background']),
          //   fit: BoxFit.fill,
          //   alignment: Alignment.bottomLeft,
          //   colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken)
          // ),
          // image: DecorationImage(
          //   image: NetworkImage("https://www.muralswallpaper.com/app/uploads/geometric-90s-plain-820x532@2x.jpg"),
          //   fit: BoxFit.cover,
          //   alignment: Alignment.bottomLeft,
          //   colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)
          // ),
          // color: Colors.amber[300],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFFf59d2a),
              Color(0xFFee7738), 
            ]
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
            color: Colors.black26,
            blurRadius: 20.0,
            spreadRadius: 3.0
          ),]
        ),
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(10.0),
        // height: 300.0,
        //doesn't affect ListView because we use itemExtent instead
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // _heroChild,
              Container(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40.0
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                child: Icon(
                  FontAwesomeIcons.longArrowAltRight,
                  size: 50.0,
                  // color: Colors.blueAccent[200],
                  color: Colors.orangeAccent[400],
                ),
                height: 100.0,
                width: 100.0,
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}