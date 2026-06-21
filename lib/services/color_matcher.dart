import 'dart:math';
import 'package:flutter/material.dart';

import '../models/light_profile.dart';
import '../models/tested_color.dart';

class ColorMatcher {
  static TestedColor findClosestColor({
    required Color targetColor,
    required List<TestedColor> palette,
  }) {
    TestedColor closest = palette.first;
    double smallestDistance = double.infinity;

    for (final testedColor in palette) {
      final paletteColor = testedColor.colorFor(LightType.white);
      final distance = _colorDistance(targetColor, paletteColor);

      if (distance < smallestDistance) {
        smallestDistance = distance;
        closest = testedColor;
      }
    }

    return closest;
  }

  static double _colorDistance(Color a, Color b) {
    final dr = (a.r * 255) - (b.r * 255);
    final dg = (a.g * 255) - (b.g * 255);
    final db = (a.b * 255) - (b.b * 255);

    return sqrt((dr * dr) + (dg * dg) + (db * db));
  }
}