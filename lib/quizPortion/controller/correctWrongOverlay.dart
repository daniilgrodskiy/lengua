import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CorrectWrongOverlay extends StatefulWidget {

  final bool _isCorrect;
  final VoidCallback _onTap; 
  final String explanation;

  CorrectWrongOverlay(this._isCorrect, this._onTap, this.explanation);

  @override
  _CorrectWrongOverlayState createState() => new _CorrectWrongOverlayState();
}

class _CorrectWrongOverlayState extends State<CorrectWrongOverlay> with SingleTickerProviderStateMixin {

  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _iconAnimationController = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    _iconAnimation = CurvedAnimation(parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => setState((){}));
    _iconAnimationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _iconAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.black54,
      child: InkWell(
        
        onTap: () => widget._onTap(),
        child: Container(
          margin: EdgeInsets.all(40.0),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   border: Border.all(color: Colors.transparent)

          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: widget._isCorrect == true ? Colors.green[100] : Colors.red[100],
                  shape: BoxShape.circle
                ),
                child: Transform.rotate(
                  angle: _iconAnimation.value * 2 * pi, //0, 0.1, 0.2, ..., 1
                  child: Icon(widget._isCorrect == true ? FontAwesomeIcons.check : FontAwesomeIcons.times, size: _iconAnimation.value * 80.0,
                  color: widget._isCorrect == true ? Colors.green : Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              // Text(widget._isCorrect == true ? "Correct!" : "Wrong!", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                decoration: BoxDecoration(
                  // color: widget._isCorrect == true ? Colors.greenAccent : Colors.redAccent[100],
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Explanation:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(widget.explanation, style: TextStyle(), textAlign: TextAlign.center,),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.all(10.0),
              // ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  // margin: EdgeInsets.only(top: 40.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.blue[200],
                        Colors.blue[300], 
                      ]
                    ),
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[400],
                        spreadRadius: 0.0,
                        offset: Offset(0.0, 7.0)
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Still confused? Tap here!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}