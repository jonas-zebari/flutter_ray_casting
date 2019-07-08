import 'package:flutter/material.dart';

import 'ray.dart';

class WallPainter extends CustomPainter {
  const WallPainter(this.walls);

  final List<Ray> walls;

  @override
  void paint(Canvas canvas, Size size) {
    for (final wall in walls) {
      canvas.drawLine(
        wall.start,
        wall.end,
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(WallPainter oldDelegate) {
    if (walls.length != oldDelegate.walls.length) return true;
    for (int index = 0; index < walls.length; index++) {
      if (walls[index] != oldDelegate.walls[index]) return true;
    }
    return false;
  }
}
