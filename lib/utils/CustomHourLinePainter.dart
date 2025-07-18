import 'package:flutter/material.dart';

class CustomHourLinePainter extends CustomPainter {
  final Color lineColor;
  final double lineHeight;

  CustomHourLinePainter({
    required this.lineColor,
    required this.lineHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineHeight;

    // Draw lines at each hour
    for (double i = 0; i <= size.height; i += 60) {
      canvas.drawLine(
        Offset(0, i),
        Offset(size.width, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomHourLinePainter oldDelegate) {
    return lineColor != oldDelegate.lineColor || lineHeight != oldDelegate.lineHeight;
  }
}
