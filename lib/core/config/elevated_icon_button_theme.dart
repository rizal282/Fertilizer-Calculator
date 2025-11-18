import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class ElevatedIconButtonTheme
    extends ThemeExtension<ElevatedIconButtonTheme> {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? radius;

  const ElevatedIconButtonTheme({
    this.backgroundColor,
    this.foregroundColor,
    this.radius,
  });

  @override
  ElevatedIconButtonTheme copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? radius,
  }) {
    return ElevatedIconButtonTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      radius: radius ?? this.radius,
    );
  }

  @override
  ElevatedIconButtonTheme lerp(
      ThemeExtension<ElevatedIconButtonTheme>? other, double t) {
    if (other is! ElevatedIconButtonTheme) return this;

    return ElevatedIconButtonTheme(
      backgroundColor:
          Color.lerp(backgroundColor, other.backgroundColor, t),
      foregroundColor:
          Color.lerp(foregroundColor, other.foregroundColor, t),
      radius: lerpDouble(radius, other.radius, t),
    );
  }
}
