import 'package:flutter/material.dart';

class DirectionsContainer extends StatefulWidget {

  final String _directions;

  DirectionsContainer(this._directions);

  @override
  _DirectionsContainerState createState() => new _DirectionsContainerState();
}


class _DirectionsContainerState extends State<DirectionsContainer> with SingleTickerProviderStateMixin {


  Animation<double> _movingRightAnimation; 
  //will have animation and it will be double; 0, 0.1, 0.2, ..., 1
  AnimationController _movingRightAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    _movingRightAnimationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _movingRightAnimation = CurvedAnimation(parent: _movingRightAnimationController, curve: Curves.easeIn);
    _movingRightAnimation.addListener(() => this.setState((){}));
    _movingRightAnimationController.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(DirectionsContainer oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget._directions != widget._directions) {
      _movingRightAnimationController.reset();
      _movingRightAnimationController.forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _movingRightAnimationController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return new Material(

      color: Colors.orangeAccent,
      child: InkWell(
        // onTap: (){
        //   Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) {
        //       return LandingPage();
        //     }
        //   ));
        // },
        child: Offstage(
          // offstage: (_movingRightAnimation.value < 0.0) ? true : false,
          offstage: false,
          child: Container(
            // margin: EdgeInsets.only(left: _movingRightAnimation.value * 100),
            alignment: FractionalOffset.center,
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
              child: Text(
                "${widget._directions}", 
                style: TextStyle(
                  fontSize: 15.0, 
                  color: Colors.white,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}