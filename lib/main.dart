import 'package:flutter/material.dart';
import 'screens/palette_screen.dart';

void main() {
  runApp(const LightPaletteApp());
}

class LightPaletteApp extends StatelessWidget {
  const LightPaletteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Light Palette Simulator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const PaletteScreen(),
    );
  }
}