import 'package:flutter/material.dart';

import 'package:flutter_rays/overlay.dart';
import 'package:flutter_rays/screen.dart';
import 'package:flutter_rays/sun_painter.dart';
import 'package:flutter_rays/wall.dart';
import 'dart:ui';

void main() => runApp(FlutterRayCasting());

class FlutterRayCasting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setSystemUiOverlayLight();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SunRays(),
    );
  }
}

class SunRays extends StatefulWidget {
  final walls = List.generate(4, (_) => Wall.random(Screen.size));

  @override
  _SunRaysState createState() => _SunRaysState();
}

class _SunRaysState extends State<SunRays> {
  var fingerPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: SunPainter(
          origin: fingerPosition,
          walls: widget.walls,
        ),
        child: GestureDetector(
          onPanUpdate: (details) =>
              setState(() => fingerPosition = details.globalPosition),
          onTapDown: (details) =>
              setState(() => fingerPosition = details.globalPosition),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          var visibleWalls = widget.walls.where((wall) => wall.isVisible);
          for (var wall in visibleWalls) {
            wall.generateNewPosition(Screen.size);
          }
        },
      ),
    );
  }
}
