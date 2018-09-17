import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {

  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  _QuestionTextState createState() => new _QuestionTextState();
}


class _QuestionTextState extends State<QuestionText> with SingleTickerProviderStateMixin {


  Animation<double> _fontSizeAnimation; 
  //will have animation and it will be double; 0, 0.1, 0.2, ..., 1
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    _fontSizeAnimationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = CurvedAnimation(parent: _fontSizeAnimationController, curve: Curves.bounceOut);
    _fontSizeAnimation.addListener(() => this.setState((){}));
    _fontSizeAnimationController.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  double _checkQuestionFontSize(String question) {
    List<String> _splitQuestion = question.split(" ");
    // print(_splitQuestion);
    if (_splitQuestion.length > 5) {
      return 15.0;
    }
    return 30.0;
  }
  

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      child: InkWell(
        // onTap: (){
        //   Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) {
        //       return LandingPage();
        //     }
        //   ));
        // },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              "${widget._question.toString()}", 
              style: TextStyle(
                // fontSize: _fontSizeAnimation.value * _checkQuestionFontSize(widget._question),
                fontSize: _checkQuestionFontSize(widget._question),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}