import 'package:flutter/material.dart';

import '../models/light_profile.dart';
import '../models/tested_color.dart';
import 'color_circle.dart';

class ColorGrid extends StatelessWidget {
  final List<TestedColor> colors;
  final LightProfile selectedLight;

  const ColorGrid({
    super.key,
    required this.colors,
    required this.selectedLight,
  });

  int _getColumns(double width) {
    if (width < 600) return 4;
    if (width < 900) return 6;
    if (width < 1200) return 8;
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _getColumns(constraints.maxWidth);

        return GridView.builder(
          padding: const EdgeInsets.all(32),
          itemCount: colors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (context, index) {
            final testedColor = colors[index];

            return ColorCircle(
              testedColor: testedColor,
              selectedLight: selectedLight,
            );
          },
        );
      },
    );
  }
}
