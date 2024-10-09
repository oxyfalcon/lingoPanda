import 'package:flutter/material.dart';

class CustomShape extends RoundedRectangleBorder
    implements WidgetStateOutlinedBorder {
  const CustomShape({this.radius = 12});
  final double radius;
  @override
  OutlinedBorder? resolve(Set<WidgetState> states) => RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}
