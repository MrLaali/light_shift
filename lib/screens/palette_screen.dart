import 'package:flutter/material.dart';

import '../data/light_profiles.dart';
import '../data/tested_color_loader.dart';
import '../models/light_profile.dart';
import '../models/tested_color.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/color_grid.dart';

class PaletteScreen extends StatefulWidget {
  const PaletteScreen({super.key});

  @override
  State<PaletteScreen> createState() => _PaletteScreenState();
}

class _PaletteScreenState extends State<PaletteScreen> {
  LightProfile selectedLight = lightProfiles.first;
  late Future<List<TestedColor>> testedColorsFuture;

  @override
  void initState() {
    super.initState();
    testedColorsFuture = loadTestedColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        selectedLight: selectedLight,
        lights: lightProfiles,
        onLightChanged: (light) {
          if (light != null) {
            setState(() {
              selectedLight = light;
            });
          }
        },
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        color: selectedLight.color,
        child: FutureBuilder<List<TestedColor>>(
          future: testedColorsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading colors',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final colors = snapshot.data ?? [];

            return ColorGrid(
              colors: colors,
              selectedLight: selectedLight,
            );
          },
        ),
      ),
    );
  }
}