import 'package:flutter/material.dart';
import 'package:flutter_rays/overlay.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settingsPage';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _sunColor = Colors.white;
  var _rayColor = Colors.yellow;
  var _bgColor = Colors.white;
  var _wallColor = Colors.black;
  var _buttonColor = Colors.deepPurpleAccent;

  void _showColorSelector(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: content,
        );
      },
    );
  }

  void _showRaySelector() {
    _showColorSelector(
      'Choose Ray Color',
      MaterialColorPicker(
        allowShades: false,
        circleSize: 75,
        selectedColor: _rayColor,
        onColorChange: (color) => setState(() => _rayColor = color),
        onMainColorChange: (color) => setState(() => _rayColor = color),
      ),
    );
  }

  void _showSunSelector() {
    _showColorSelector(
      'Choose Sun Color',
      MaterialColorPicker(
        allowShades: false,
        circleSize: 75,
        selectedColor: _sunColor,
        onColorChange: (color) => setState(() => _sunColor = color),
        onMainColorChange: (color) => setState(() => _sunColor = color),
      ),
    );
  }

  void _showBackgroundSelector() {
    _showColorSelector(
      'Choose Background Color',
      MaterialColorPicker(
        allowShades: false,
        circleSize: 75,
        selectedColor: _bgColor,
        onColorChange: (color) => setState(() => _bgColor = color),
        onMainColorChange: (color) => setState(() => _bgColor = color),
      ),
    );
  }

  void _showWallSelector() {
    _showColorSelector(
      'Choose Wall Color',
      MaterialColorPicker(
        allowShades: false,
        circleSize: 75,
        selectedColor: _wallColor,
        onColorChange: (color) => setState(() => _wallColor = color),
        onMainColorChange: (color) => setState(() => _wallColor = color),
      ),
    );
  }

  void _showButtonSelector() {
    _showColorSelector(
      'Choose Button Color',
      MaterialColorPicker(
        allowShades: false,
        circleSize: 75,
        selectedColor: _buttonColor,
        onColorChange: (color) => setState(() => _buttonColor = color),
        onMainColorChange: (color) => setState(() => _buttonColor = color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setSystemUiOverlayLight();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(
              ColorSelections(
                sun: _sunColor,
                rays: _rayColor,
                wall: _wallColor,
                background: _bgColor,
                button: _buttonColor,
              ),
            );
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 12),
          ColorSelectionTile(
            title: 'Ray color',
            subtitle: 'The color of the lines being cast from the sun',
            color: _rayColor,
            showDialog: _showRaySelector,
          ),
          ColorSelectionTile(
            title: 'Sun color',
            subtitle: 'The color of the sun that is casting rays',
            color: _sunColor,
            showDialog: _showSunSelector,
          ),
          ColorSelectionTile(
            title: 'Background color',
            subtitle: 'The color the of scene\'s background',
            color: _bgColor,
            showDialog: _showBackgroundSelector,
          ),
          ColorSelectionTile(
            title: 'Wall color',
            subtitle: 'The color the walls that stop the rays',
            color: _wallColor,
            showDialog: _showWallSelector,
          ),
          ColorSelectionTile(
            title: 'Button color',
            subtitle: 'The primary theme color',
            color: _buttonColor,
            showDialog: _showButtonSelector,
          ),
        ],
      ),
    );
  }
}

class ColorSelectionTile extends StatelessWidget {
  ColorSelectionTile({this.title, this.subtitle, this.color, this.showDialog});

  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback showDialog;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: PlainFloatingCircle(
        color: color,
        onTap: showDialog,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}

class PlainFloatingCircle extends StatelessWidget {
  PlainFloatingCircle({this.color, this.elevation = 4.0, this.onTap});

  final Color color;
  final double elevation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: color,
      elevation: elevation,
      heroTag: null,
      child: null,
      onPressed: onTap,
    );
  }
}

class ColorSelections {
  const ColorSelections({
    this.sun,
    this.rays,
    this.background,
    this.button,
    this.wall,
  });
  final Color sun;
  final Color rays;
  final Color background;
  final Color button;
  final Color wall;
}
