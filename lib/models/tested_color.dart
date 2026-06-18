import 'package:flutter/material.dart';
import 'light_profile.dart';

class TestedColor {
  final String name;
  final Map<LightType, Color> colors;

  const TestedColor({
    required this.name,
    required this.colors,
  });

  Color colorFor(LightType lightType) {
    return colors[lightType] ?? colors[LightType.white]!;
  }
}