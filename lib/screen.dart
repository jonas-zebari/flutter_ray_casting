import 'dart:ui';

abstract class Screen {
  static final double height =
      window.physicalSize.height / window.devicePixelRatio;
  static final double width =
      window.physicalSize.width / window.devicePixelRatio;
  static final Size size = Size(width, height);
}
