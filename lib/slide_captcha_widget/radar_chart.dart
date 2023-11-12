import 'dart:math';

import 'package:flutter/material.dart';

class RadarChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final double maxValue;

  RadarChart(
      {required this.data, required this.labels, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:
          RadarChartPainter(data: data, labels: labels, maxValue: maxValue),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;
  final double maxValue;

  RadarChartPainter(
      {required this.data, required this.labels, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width / 2, size.height / 2);
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    for (int i = 0; i < data.length; i++) {
      final angle = 2 * pi * (i / data.length);
      final valueRatio = data[i] / maxValue;
      final x = center.dx + radius * cos(angle) * valueRatio;
      final y = center.dy + radius * sin(angle) * valueRatio;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);

    final labelPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final labelOffset = Offset(0, 10);

    for (int i = 0; i < labels.length; i++) {
      final angle = 2 * pi * (i / data.length);
      final valueRatio = 1.2;
      final x = center.dx + radius * cos(angle) * valueRatio;
      final y = center.dy + radius * sin(angle) * valueRatio;

      canvas.drawCircle(Offset(x, y), 3, labelPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - textPainter.width / 2, y + labelOffset.dy));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
