import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Ray {
  Ray(this.start, this.end);

  factory Ray.random(Size bounds) {
    final rand = Random();
    final start = Offset(
      rand.nextDouble() * bounds.width,
      rand.nextDouble() * bounds.height,
    );
    final end = Offset(
      rand.nextDouble() * bounds.width,
      rand.nextDouble() * bounds.height,
    );
    return Ray(start, end);
  }

  Offset start;
  Offset end;

  double get length => sqrt(lengthSquared);

  double get lengthSquared =>
      pow(start.dx - end.dx, 2) + pow(start.dy - end.dy, 2);

  Offset intersect(Ray other, {double tolerance = 0.0}) {
    final x1 = other.start.dx;
    final y1 = other.start.dy;
    final x2 = other.end.dx;
    final y2 = other.end.dy;
    
    final x3 = this.start.dx;
    final y3 = this.start.dy;
    final x4 = this.end.dx;
    final y4 = this.end.dy;

    final den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);

    if (den == 0) {
      return null;
    }

    final t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    final u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;

    if (t >= 0 && t <= 1 && u >= 0 && u <= 1) {
      final x = x1 + t * (x2 - x1);
      final y = y1 + t * (y2 - y1);
      return Offset(x, y); // The point of intersection
    } else {
      return null;
    }
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! Ray) return false;
    final Ray typedOther = other;
    return start == typedOther.start && end == typedOther.end;
  }

  @override
  int get hashCode => hashValues(start, end);
}
