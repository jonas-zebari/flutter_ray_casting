import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rays/screen.dart';
import 'package:flutter_rays/wall.dart';

class SunPainter extends CustomPainter {
  static final _sunPaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 1
    ..color = Colors.yellow.withAlpha(100);

  static final _wallPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 3;

  static final _maxRayLength = sqrt(pow(Screen.width, 2) + pow(Screen.height, 2));

  const SunPainter({this.origin = Offset.zero, this.walls});

  final Offset origin;
  final List<Wall> walls;

  @override
  void paint(Canvas canvas, Size size) {
    _drawRays(canvas);
    _drawWalls(canvas);
    canvas.drawCircle(origin, 16, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(SunPainter old) => origin != old.origin;

  void _drawRays(Canvas canvas) {
    for (double angle = 0; angle < 360; angle += 0.5) {
      // The un-clipped line
      final ray = Wall.fromAngle(origin, _radians(angle), _maxRayLength);
      // Find the closest point of intersection
      double recordLength = double.infinity;
      // Check ray against every wall
      for (var wall in walls) {
        // The current intersection point, if any
        final intersect = ray.intersection(wall);
        // Test whether this intersection is closer than the current record
        if (intersect != null) {
          // Ray length to intersect current wall
          final length = _distance(ray.start, intersect);
          // Overwrite closest intersect if current is closer
          if (length < recordLength) {
            recordLength = length;
            ray.end = intersect;
          }
        }
      }

      canvas.drawLine(ray.start, ray.end, _sunPaint);
    }
  }

  void _drawWalls(Canvas canvas) {
    for (var wall in walls.where((wall) => wall.isVisible)) {
      canvas.drawLine(wall.start, wall.end, _wallPaint);
    }
  }

  double _radians(num angle) => (angle * pi) / 180;

  double _distance(Offset a, Offset b) =>
      sqrt(pow(b.dx - a.dx, 2) + pow(b.dy - a.dy, 2));
}
