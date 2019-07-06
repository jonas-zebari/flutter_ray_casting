import 'package:flutter/material.dart';

class SunPosition extends ValueNotifier<Offset> {
  SunPosition(Offset value) : super(value);
  factory SunPosition.zero() => SunPosition(Offset.zero);
  factory SunPosition.center(Size size) =>
      SunPosition(Offset(size.width / 2, size.height / 2));
}
