import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rays/screen.dart';
import 'package:flutter_rays/wall.dart';

class SunPainter extends CustomPainter {
//  final _sunPaint = Paint()
//    ..style = PaintingStyle.fill
//    ..strokeWidth = 1
//    ..color = Colors.yellow.withAlpha(100);
//
//  final _wallPaint = Paint()
//    ..style = PaintingStyle.stroke
//    ..color = Colors.black
//    ..strokeCap = StrokeCap.round
//    ..strokeWidth = 3;
//
//  final _centerPaint = Paint()..color = Colors.white;

  static final _maxRayLength =
      sqrt(pow(Screen.width, 2) + pow(Screen.height, 2));

  SunPainter({
    this.origin = Offset.zero,
    this.walls,
    this.wallColor,
    this.rayColor,
    this.sunColor,
  }) {
    _rayPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = rayColor;
    _wallPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = wallColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    _sunPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = sunColor;
  }

  Paint _sunPaint;
  Paint _wallPaint;
  Paint _rayPaint;

  final Offset origin;
  final List<Wall> walls;
  final Color wallColor;
  final Color sunColor;
  final Color rayColor;

  void _drawRays(Canvas canvas) {
    for (double angle = 0; angle < 360; angle += 0.5) {
      // The un-clipped line
      final ray = Wall.fromAngle(origin, _radians(angle), _maxRayLength);
      // Find the closest intersection point if it exists
      double recordLength = double.infinity;
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

      canvas.drawLine(ray.start, ray.end, _rayPaint);
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

  @override
  void paint(Canvas canvas, Size size) {
    _drawRays(canvas);
    _drawWalls(canvas);
    canvas.drawCircle(origin, 16, _sunPaint);
  }

  @override
  bool shouldRepaint(SunPainter old) => true;
}
