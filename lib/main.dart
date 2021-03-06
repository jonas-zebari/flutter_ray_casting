import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ray.dart';
import 'sun_painter.dart';
import 'wall_painter.dart';

void main() => runApp(RayCastingApp());

class RayCastingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SunCaster(),
    );
  }
}

class SunCaster extends StatelessWidget {
  final _position = ValueNotifier<Offset>(Offset(100, 100));
  final _walls = List<Ray>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _walls.addAll(List.generate(4, (index) => Ray.random(size)));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: GestureDetector(
          onPanUpdate: (details) => _position.value = details.globalPosition,
          child: ValueListenableBuilder<Offset>(
            valueListenable: _position,
            builder: (context, value, child) {
              return CustomPaint(
                painter: SunPainter(value, _walls, MediaQuery.of(context).size),
                foregroundPainter: WallPainter(_walls),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () => _walls.add(Ray.random(size)),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: Icon(Icons.remove),
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () => _walls.removeLast(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: Icon(Icons.refresh),
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () {
              final count = _walls.length;
              _walls.clear();
              _walls.addAll(List.generate(count, (index) => Ray.random(size)));
            },
          ),
        ],
      ),
    );
  }
}
