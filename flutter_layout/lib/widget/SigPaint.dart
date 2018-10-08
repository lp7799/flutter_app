import 'package:flutter/material.dart';


class MyCustomPainter extends CustomPainter{
  MyCustomPainter(this.points);
  final List<Offset> points;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.blue[200]
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..strokeJoin = StrokeJoin.bevel;
    for(int i=0;i<points.length-1;i++){
      if(points[i] != null && points[i+1] != null){
        canvas.drawLine(points[i], points[i+1], paint);

      }
    }
  }
  ///是否可以重绘
  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
class SigPaint extends StatefulWidget {
  @override
  _SigPaintState createState() => _SigPaintState();
}

class _SigPaintState extends State<SigPaint> {
  List<Offset> _points = new List<Offset>();

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Stack(
        children: <Widget>[
          GestureDetector(
            onPanUpdate: (DragUpdateDetails details){
                RenderBox referenceBox = context.findRenderObject();
                Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
                setState(() {
                  _points = new List.from(_points)..add(localPosition);
                });
            },
            onPanEnd:(DragEndDetails details){
              return _points.add(null);
            },
          ),
          CustomPaint(painter: new MyCustomPainter(_points),)
        ],
      ),
    );
  }
}
