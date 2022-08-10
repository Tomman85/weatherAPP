import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:path_drawing/path_drawing.dart';

import 'package:vector_math/vector_math_64.dart' as v3;

class SunArch extends StatefulWidget {
  final double lineDegree;
  final double sunDegree;
  final Color color;

  const SunArch({
    Key? key,
    required this.lineDegree,
    required this.sunDegree,
    required this.color,
  }) : super(key: key);

  @override
  State<SunArch> createState() => _SunArchState();
}

class _SunArchState extends State<SunArch> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: DashLine(),
        ),
        CustomPaint(
          painter: FillLine(degree: widget.lineDegree),
        ),
        CustomPaint(
          painter: Sun(degree: widget.sunDegree, color: widget.color),
        ),
      ],
    );
  }
}

class DashLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var path = Path();
    path.addArc(
        Rect.fromCircle(center: Offset(0, 180), radius: 180), -2.5, 2.0);

    canvas.drawPath(
        dashPath(path, dashArray: CircularIntervalList([7.0, 8.0])), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class FillLine extends CustomPainter {
  final double degree;

  FillLine({
    required this.degree,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    //draw arc

    var path = Path();
    path.addArc(
        Rect.fromCircle(center: Offset(0, 180), radius: 180), -2.6, degree);
    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Sun extends CustomPainter {
  final double degree;
  final Color color;

  Sun({
    required this.degree,
    required this.color,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Offset pointOnCircle = Offset(
      (180 * math.sin(4.2-degree)),
      (180 * math.cos(4.2-degree) + 180),
    );

    // For showing the point moving on the circle
    canvas.drawCircle(pointOnCircle, 10, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
