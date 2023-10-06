import 'package:flutter/material.dart';

import 'custom_paint.dart';

class Pencil extends CustomPainter{
  List<PathPainter> pathPainters;


  Pencil(this.pathPainters);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
        ..style = PaintingStyle.fill;

    for (PathPainter pathPainter in pathPainters) {
      paint.color = pathPainter.color;
      canvas.drawCircle(Offset(pathPainter.x, pathPainter.y), pathPainter.radius, paint);
    }


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}


