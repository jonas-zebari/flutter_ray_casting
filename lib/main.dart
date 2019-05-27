import 'package:flutter/material.dart';

import 'package:flutter_rays/overlay.dart';
import 'package:flutter_rays/screen.dart';
import 'package:flutter_rays/settings_page.dart';
import 'package:flutter_rays/sun_painter.dart';
import 'package:flutter_rays/wall.dart';
import 'dart:ui';

void main() => runApp(FlutterRayCasting());

class FlutterRayCasting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setSystemUiOverlayLight();
    return MaterialApp(
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
  var _fingerPosition = Offset(Screen.width / 2, Screen.height / 2);
  var _buttonColor = Colors.deepPurpleAccent;
  var _backgroundColor = Colors.white;
  var _rayColor = Colors.yellow;
  var _sunColor = Colors.white;
  var _wallColor = Colors.black;

  void _generateNewWalls() {
    for (var wall in widget.walls) {
      if (wall.isVisible) {
        wall.generateNewPosition(Screen.size);
      }
    }
  }

  void _updatePosition(Offset pos) {
    setState(() {
      _fingerPosition = pos;
    });
  }

  void _updateSettings(ColorSelections settings) {
    setState(() {
      _rayColor = settings.rays;
      _sunColor = settings.sun;
      _wallColor = settings.wall;
      _backgroundColor = settings.background;
      _buttonColor = settings.button;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: CustomPaint(
        painter: SunPainter(
          origin: _fingerPosition,
          walls: widget.walls,
          sunColor: _sunColor,
          rayColor: _rayColor,
          wallColor: _wallColor,
        ),
        child: GestureDetector(
          onPanUpdate: (details) => _updatePosition(details.globalPosition),
          onTapDown: (details) => _updatePosition(details.globalPosition),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.settings),
              backgroundColor: _buttonColor,
              onPressed: () async {
                final route = MaterialPageRoute<ColorSelections>(
                  builder: (context) => SettingsPage(),
                );
                final result = await Navigator.push(context, route);
                _updateSettings(result);
              },
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.refresh),
            backgroundColor: _buttonColor,
            onPressed: _generateNewWalls
          ),
        ],
      ),
    );
  }
}
