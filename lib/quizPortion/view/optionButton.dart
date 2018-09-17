import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {

  final String _option;
  final int _optionNumber;
  final VoidCallback _onTap;
  final int _questionNumber;
  //we need _questionNumber for the updateWidget() method; previously, I used _option and compared it to the old answer, but I ran into the problem where the _option was the same for both the previous question and the next question (not a glitch; I was just reusing answers). Because the condition for the animation to occur tested whether the previous answer equalled the new answer, this meant that the animation for that answer would not occur. To fix this, I am choosing to use _questionNumber because it will almost definitively be dynamic and different everytime, thus allowing the animations for the optionButtons to occur.

  OptionButton(this._option, this._optionNumber, this._onTap, this._questionNumber);

  @override
  OptionButtonState createState() {
    return new OptionButtonState();
  }
}

class OptionButtonState extends State<OptionButton> with TickerProviderStateMixin {

  Animation _fontSizeAnimation; 
  //will have animation and it will be double; 0, 0.1, 0.2, ..., 1
  AnimationController _fontSizeAnimationController;

  Animation<Offset> _buttonPosition;

  @override
  void initState() {
    // TODO: implement initState
    _fontSizeAnimationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _fontSizeAnimation = Tween(begin: 0.0, end: 1.0)
    .animate(CurvedAnimation(
      parent: _fontSizeAnimationController,
      curve: Interval(
        0.0, 0.2 * widget._optionNumber,
        curve: Curves.easeIn
      ),
    ));
    _fontSizeAnimation.addListener(() => this.setState((){}));
    _fontSizeAnimationController.forward();

    _buttonPosition = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _fontSizeAnimationController,
      curve: Interval(
        0.0, 0.25 * widget._optionNumber,
        curve: Curves.easeOut
      ),
    )
    );

    super.initState();

  }

  @override
  void didUpdateWidget(OptionButton oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget._questionNumber != widget._questionNumber) {
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

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: Center(
        child: Container(
          width: _fontSizeAnimation.value * MediaQuery.of(context).size.width,
          height: _fontSizeAnimation.value * 100,
          decoration: BoxDecoration(
            color: Colors.orange,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.orange[700],
                offset: Offset(0.0, 10.0)
              ),
            ],
          ),
          margin: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => widget._onTap(),
            child: Center(
              child: Container(
                // padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.white, width: 5.0)
                ),
                child: Text(
                  widget._option,
                  style: TextStyle(color: Colors.white, fontSize: _fontSizeAnimation.value * 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Text(widget._option),
    // );
  }
}