import 'package:Lengua/authFiles/auth.dart';
import 'package:Lengua/generalTopicsPage.dart';
import 'package:Lengua/specificTopicsPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_background/animated_background.dart';

class ScorePage extends StatefulWidget {

  final generalTopicIndex;
  final specificTopicIndex;
  final appBarTitle;
  final user;
  final googleSignIn;
  final BaseAuth auth;

  final int score;
  final int totalQuestions;

  ScorePage(this.generalTopicIndex, this.specificTopicIndex, this.appBarTitle, this.user, this.googleSignIn, this.auth, this.score, this.totalQuestions);

  @override
  ScorePageState createState() {
    return new ScorePageState();
  }
}

class ScorePageState extends State<ScorePage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.black38,
        child: AnimatedBackground(
          vsync: this,
          // behaviour: RandomParticleBehaviour(
          //   options: ParticleOptions(
          //     baseColor: Colors.orange[400]
          //   )
          // ),
          behaviour: BubblesBehaviour(
            options: BubbleOptions(
              
            ),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(40.0, 150.0, 40.0, 150.0),
            // decoration: BoxDecoration(
            //   color: Colors.black26,
            //   border: Border.all(color: Colors.transparent),
            //   borderRadius: BorderRadius.circular(20.0)
            // ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Your score: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50.0),),
                  Text(widget.score.toString() + " out of " + widget.totalQuestions.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50.0),),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowCircleRight
                    ),
                    color: Colors.orangeAccent,
                    iconSize: 100.0,
                    onPressed: () => 
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (BuildContext context) => 
                        SpecificTopicsPage(
                          generalTopicIndex: widget.generalTopicIndex, 
                          appBarTitle: widget.appBarTitle,
                          user: widget.user,
                          googleSignIn: widget.googleSignIn,
                          auth: widget.auth,
                          ),
                        ), 
                      (Route route) => route == MaterialPageRoute(
                          builder: (BuildContext context) => 
                          GeneralTopicsPage(
                            auth: widget.auth,
                            user: widget.user,
                            googleSignIn: widget.googleSignIn,
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}