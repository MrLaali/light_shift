import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/light_profile.dart';
import '../models/tested_color.dart';

Future<List<TestedColor>> loadTestedColors() async {
  final csvString = await rootBundle.loadString('assets/colors.csv');

  final rows = const CsvDecoder().convert(csvString);

  final dataRows = rows.skip(1);

  return dataRows.map((row) {
    return TestedColor(
      name: row[0].toString(),
      colors: {
        LightType.white: _hexToColor(row[1].toString()),
        LightType.red: _hexToColor(row[2].toString()),
        LightType.green: _hexToColor(row[3].toString()),
        LightType.blue: _hexToColor(row[4].toString()),
        LightType.yellow: _hexToColor(row[5].toString()),
        LightType.magenta: _hexToColor(row[6].toString()),
        LightType.cyan: _hexToColor(row[7].toString()),
      },
    );
  }).toList();
}

Color _hexToColor(String hex) {
  final cleaned = hex.trim().replaceAll('#', '');
  return Color(int.parse('FF$cleaned', radix: 16));
}