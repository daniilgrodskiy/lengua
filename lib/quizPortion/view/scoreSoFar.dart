import 'package:flutter/material.dart';

class ScoreSoFar extends StatefulWidget {

  final int numberCorrect;
  final int numberWrong;

  const ScoreSoFar(this.numberCorrect, this.numberWrong);
  
  
  @override
  _ScoreSoFarState createState() => new _ScoreSoFarState();
}

class _ScoreSoFarState extends State<ScoreSoFar> {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: Material(
          color: Colors.blue[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  //correct answers
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.green[400],
                          Colors.green[500]
                        ]
                      ),
                    ),
                    margin: const EdgeInsets.only(left: 10.0),
                    height: 30.0,
                    width: 30.0,
                  ),
                  Container(
                    child: Text(
                      "  :  " + widget.numberCorrect.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  //incorrect answers
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.red[400],
                          Colors.red[500]
                        ]
                      ),
                    ),
                    margin: const EdgeInsets.only(left: 40.0),
                    height: 30.0,
                    width: 30.0,
                  ),
                  Container(
                    child: Text(
                      "  :  " + (widget.numberWrong).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}