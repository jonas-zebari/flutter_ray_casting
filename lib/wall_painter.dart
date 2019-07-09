import 'package:flutter/material.dart';

import 'ray.dart';

class WallPainter extends CustomPainter {
  const WallPainter(this.walls);

  static final _wallPaint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;

  final List<Ray> walls;

  @override
  void paint(Canvas canvas, Size size) {
    for (final wall in walls) {
      canvas.drawLine(
        wall.start,
        wall.end,
        _wallPaint,
      );
    }
  }

  @override
  bool shouldRepaint(WallPainter oldDelegate) {
    if (walls.length != oldDelegate.walls.length) return true;
    for (int index = 0; index < walls.length; index++)
      if (walls[index] != oldDelegate.walls[index]) return true;
    return false;
  }
}
