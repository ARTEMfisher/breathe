import 'package:flutter/material.dart';
import 'dart:math';

class ProgressPainter extends CustomPainter {
  final double value;
  ProgressPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBackground = Paint()
      ..color = Colors.grey.shade300
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50
      ..isAntiAlias = true;

    final Paint paintProgress = Paint()
      ..color = Colors.limeAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50
      ..isAntiAlias = true;

    final Rect rect = Offset(0, 0) & size;
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * pi * value;

    canvas.drawArc(rect, startAngle, 2 * pi, false, paintBackground);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paintProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
