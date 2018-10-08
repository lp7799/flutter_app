import 'package:flutter/material.dart';


class MyCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    var paints = new Paint()
      ..color = Colors.white
      ..isAntiAlias = true;

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
  }

}


class BubbleView extends StatefulWidget {
  @override
  _BubbleViewState createState() => _BubbleViewState();
}

class _BubbleViewState extends State<BubbleView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border.all(width: 2.0,color: Colors.white),
        color: Colors.cyanAccent,
        borderRadius: new BorderRadius.circular(18.0),
      ),
      child: null,
    );
  }
}
