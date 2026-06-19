import 'package:flutter/services.dart';

import '../models/light_profile.dart';
import '../models/tested_color.dart';

Future<List<TestedColor>> loadTestedColors() async {
  final csvString = await rootBundle.loadString('assets/colors.csv');

  final lines = csvString
      .split('\n')
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();

  final dataLines = lines.skip(1);

  return dataLines.map((line) {
    final values = line.split(',');

    return TestedColor(
      name: values[0],
      colors: {
        LightType.white: _hexToColor(values[1]),
        LightType.red: _hexToColor(values[2]),
        LightType.green: _hexToColor(values[3]),
        LightType.blue: _hexToColor(values[4]),
        LightType.yellow: _hexToColor(values[5]),
        LightType.magenta: _hexToColor(values[6]),
        LightType.cyan: _hexToColor(values[7]),
      },
    );
  }).toList();
}

Color _hexToColor(String hex) {
  final cleaned = hex.replaceAll('#', '');
  return Color(int.parse('FF$cleaned', radix: 16));
}