import 'dart:math' as math;
import 'dart:io';

void main() {
  var test = read('Input: ');
  print(test);
}

String read([String message]) {
  if (message != null) 
    stdout.write(message);

  return stdin.readLineSync();
}

void calculatePi() {
  const int iterations = 10000;
  double pi = 0.0;
  int trueCount = 0;
  generatePoints(iterations).listen((point) {
    if (point.isInUnitCircle) {
      pi = (++trueCount / iterations) * 4;
    }
    print('${point.toStringAsFixed(3)} -> $pi');
  });
}

Stream<Point> generatePoints(int count) async* {
  for (int i = 0; i < count; i++) yield Point.random();
}

final rand = math.Random();

class Point {
  Point(this.x, this.y);
  double x, y;
  bool get isInUnitCircle => math.sqrt((math.pow(x, 2) + math.pow(y, 2))) <= 1;
  factory Point.random() => Point(rand.nextDouble(), rand.nextDouble());
  @override
  String toString() => '($x, $y)';
  String toStringAsFixed(int acc) => '(${x.toStringAsFixed(acc)}, ${y.toStringAsFixed(acc)})';
}