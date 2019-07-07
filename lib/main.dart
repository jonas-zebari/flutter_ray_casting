import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rays/theme_state.dart';
import 'package:provider/provider.dart';

import 'sun_position.dart';
import 'overlay.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setSystemUiOverlayLight();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      home: LayoutBuilder(
        builder: (context, constraints) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<SunPosition>(
                builder: (context) => SunPosition.center(constraints.biggest),
              ),
              ChangeNotifierProvider<ThemeState>(
                builder: (context) => ThemeState.light(),
              ),
              Provider<Size>.value(value: constraints.biggest),
            ],
            child: RayCastingApp(),
          );
        },
      ),
    );
  }
}

class RayCastingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SunPosition, ThemeState>(
      builder: (context, sunPosition, theme, child) {
        final size = Provider.of<Size>(context);
        return Container(
          color: theme.backgroundColor,
          child: GestureDetector(
            onPanUpdate: (details) =>
                sunPosition.value = details.globalPosition,
            onTapDown: (details) => theme.toggle(),
            child: CustomPaint(
              painter: SunPainter(
                position: sunPosition.value,
                sunColor: theme.sunColor,
                maxSize: size,
                radius: 30,
                numRays: 180,
              ),
            ),
          ),
        );
      },
    );
  }
}

class SunPainter extends CustomPainter {
  static const _twoPi = 2 * pi;

  const SunPainter({
    this.maxSize,
    this.position = Offset.zero,
    this.sunColor = Colors.yellow,
    this.radius = 20,
    this.numRays = 360,
  });

  final Offset position;
  final Size maxSize;
  final Color sunColor;
  final double radius;
  final int numRays;

  void _drawSun(Canvas canvas) {
    final shadowRect = Rect.fromCircle(center: position, radius: radius);
    final shadowPath = Path()..addOval(shadowRect);
    canvas.drawShadow(shadowPath, Colors.black, 4, false);
    canvas.drawCircle(position, radius, Paint()..color = sunColor);
  }

  void _drawRays(Canvas canvas) {
    final sunPaint = Paint()..color = sunColor;
    final inc = _twoPi / numRays;
    for (double angle = 0.0; angle < _twoPi; angle += inc) {
      final endPoint = Offset.fromDirection(angle, 2000) + position;
      canvas.drawLine(position, endPoint, sunPaint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawRays(canvas);
    _drawSun(canvas);
  }

  @override
  bool shouldRepaint(SunPainter oldDelegate) => true;
}
