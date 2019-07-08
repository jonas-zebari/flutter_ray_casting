import 'dart:math';

import 'package:flutter/material.dart';

import 'ray.dart';

class SunPainter extends CustomPainter {
  const SunPainter(this.position, this.walls, this.size);

  final Offset position;
  final List<Ray> walls;
  final Size size;

  void _drawRays(Canvas canvas) {
    final inc = (2 * pi) / 180;
    for (double angle = inc; angle < (2 * pi); angle += inc) {
      final ray = Ray(position,
          Offset.fromDirection(angle, size.longestSide * 2) + position);
      for (final wall in walls) {
        final intersection = ray.intersect(wall);
        if (intersection != null) {
          final testRay = Ray(ray.start, intersection);
          if (testRay.lengthSquared < ray.lengthSquared) {
            ray.end = testRay.end;
          }
        }
      }
      canvas.drawLine(
        ray.start,
        ray.end,
        Paint()
          ..color = Colors.yellow
          ..strokeWidth = 2,
      );
    }
  }

  void _drawSun(Canvas canvas) {
    const radius = 20.0;
    final shadowRect = Rect.fromCircle(center: position, radius: radius);
    final shadowPath = Path()..addOval(shadowRect);
    canvas.drawShadow(shadowPath, Colors.black, 4, false);
    canvas.drawCircle(position, radius, Paint()..color = Colors.yellow);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawRays(canvas);
    _drawSun(canvas);
  }

  @override
  bool shouldRepaint(SunPainter oldDelegate) => true;
}
