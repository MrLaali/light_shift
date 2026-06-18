import 'package:flutter/material.dart';

enum LightType {
  white,
  red,
  green,
  blue,
  yellow,
  magenta,
  cyan,
}

class LightProfile {
  final LightType type;
  final String name;
  final Color color;

  const LightProfile({
    required this.type,
    required this.name,
    required this.color,
  });
}