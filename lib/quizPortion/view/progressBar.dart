import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {

  final int currentQuestionNumber;
  final int totalQuestions;

  const ProgressBar(this.currentQuestionNumber, this.totalQuestions);

  @override
  _ProgressBarState createState() => new _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> with TickerProviderStateMixin{



  Animation<double> _progressBarWidthAnimation; 
  //will have animation and it will be double; 0, 0.1, 0.2, ..., 1
  AnimationController _progressBarWidthAnimationController;


  AnimationController _movingProgressBarPartController;
  Animation<Offset> _movingProgressBarPartPosition;


  double progressBarWidth() {
    return (widget.currentQuestionNumber) / widget.totalQuestions *  MediaQuery.of(context).size.width + (_progressBarWidthAnimation.value / widget.totalQuestions *  MediaQuery.of(context).size.width) - ( (1 / widget.totalQuestions * MediaQuery.of(context).size.width));
  }

  @override
  void initState() {
    // TODO: implement initState
    _progressBarWidthAnimationController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _progressBarWidthAnimation = CurvedAnimation(parent: _progressBarWidthAnimationController, curve: Curves.easeOut);
    _progressBarWidthAnimation.addListener(() => this.setState((){}));
    _progressBarWidthAnimationController.forward();
    // _progressBarWidthAnimationController.repeat();


    // _movingProgressBarPartController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    // _movingProgressBarPartPosition.addListener(() => this.setState((){}));
    // _movingProgressBarPartController.forward();

    // _movingProgressBarPartPosition = Tween<Offset>(
    //   begin: Offset(0.0, 1.0),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(
    //   parent: _movingProgressBarPartController,
    //   curve: Interval(
    //     0.0, 1.0,
    //     curve: Curves.easeOut
    //   ),
    // )
    // );

    super.initState();
  }

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentQuestionNumber != widget.currentQuestionNumber) {
      _progressBarWidthAnimationController.reset();
      _progressBarWidthAnimationController.forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _progressBarWidthAnimationController.dispose();
    // _movingProgressBarPartController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Material(
          color: Colors.orange[200],
          child: Container(
            height: 30.0,
          ),
        ),
        
          new Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            // padding: EdgeInsets.all(50.0),
            decoration: BoxDecoration(
              color: Colors.green[400],
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15.0)
            ),
            height: 15.0,
            // width: (_progressBarWidthAnimation.value * widget.currentQuestionNumber) / 12 *  MediaQuery.of(context).size.width,

            // width: widget.currentQuestionNumber != 1 ?   (widget.currentQuestionNumber) / widget.totalQuestions *  MediaQuery.of(context).size.width + (_progressBarWidthAnimation.value / widget.totalQuestions *  MediaQuery.of(context).size.width) - ( 2 * (1 / widget.totalQuestions * MediaQuery.of(context).size.width))
            // : 0.0,

            width: progressBarWidth() == double.tryParse(progressBarWidth().toString()) ? (widget.currentQuestionNumber) / widget.totalQuestions *  MediaQuery.of(context).size.width + (_progressBarWidthAnimation.value / widget.totalQuestions *  MediaQuery.of(context).size.width) - ( (1 / widget.totalQuestions * MediaQuery.of(context).size.width)) : 0.0,
          
        ),
        // SlideTransition(
        //   position: _movingProgressBarPartPosition,
        //   child: Material(
        //     color: Colors.green[200],
        //     child: Container(
        //       margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        //       // padding: EdgeInsets.all(50.0),
        //       decoration: BoxDecoration(
        //         color: Colors.green[400],
        //         border: Border.all(color: Colors.transparent),
        //         borderRadius: BorderRadius.circular(15.0)
        //       ),
        //       height: 15.0,

        //       width: progressBarWidth() == double.tryParse(progressBarWidth().toString()) ? (widget.currentQuestionNumber) / widget.totalQuestions *  MediaQuery.of(context).size.width + (_progressBarWidthAnimation.value / widget.totalQuestions *  MediaQuery.of(context).size.width) - ( (1 / widget.totalQuestions * MediaQuery.of(context).size.width)) : 0.0,
            
        //     ),
        //   ),
        // ),
      ],
    );
  }
}