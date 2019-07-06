import 'package:flutter/material.dart';

import 'overlay.dart';

class ThemeState with ChangeNotifier {
  ThemeState._();

  factory ThemeState.light() => ThemeState._();

  Color _sunColor = Colors.yellow;
  Color _backgroundColor = Colors.white;
  bool _isDark = false;

  void toggle() {
    if (_isDark) {
      setSunColor(Colors.yellow);
      setBackgroundColor(Colors.white);
      setSystemUiOverlayLight();
    } else {
      setSunColor(Colors.purpleAccent);
      setBackgroundColor(Colors.grey[900]);
      setSystemUiOverlayDark();
    }
    _isDark = !_isDark;
  }

  Color get sunColor => _sunColor;

  void setSunColor(Color value) {
    if (_sunColor == value) {
      return;
    }

    _sunColor = value;
    notifyListeners();
  }

  Color get backgroundColor => _backgroundColor;

  void setBackgroundColor(Color value) {
    if (_backgroundColor == value) {
      return;
    }

    _backgroundColor = value;
    notifyListeners();
  }
}
