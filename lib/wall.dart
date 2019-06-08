import 'dart:math';
import 'dart:ui';

class Wall {
  Wall(this.start, this.end, {this.isVisible = true});
  Offset start, end;
  bool isVisible;

  double get length => sqrt(lengthSquared);

  double get lengthSquared => pow(start.dx - end.dx, 2) + pow(start.dy - end.dy, 2);

  factory Wall.fromAngle(Offset position, double radians, double length) {
    final end = Offset.fromDirection(radians, length) + position;
    return Wall(position, end);
  }

  factory Wall.random(Size bounds) {
    final rand = Random();
    final start = Offset(
      rand.nextDouble() * bounds.width,
      rand.nextDouble() * bounds.height,
    );
    final end = Offset(
      rand.nextDouble() * bounds.width,
      rand.nextDouble() * bounds.height,
    );
    return Wall(start, end);
  }

  static Offset randomBoundedOffset(Size bounds) {
    final rand = Random();
    return Offset(
      rand.nextDouble() * bounds.width,
      rand.nextDouble() * bounds.height,
    );
  }

  void generateNewPosition(Size bounds) {
    this.start = randomBoundedOffset(bounds);
    this.end = randomBoundedOffset(bounds);
  }

  Offset intersection(Wall other) {
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
}
