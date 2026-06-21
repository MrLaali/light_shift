import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

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
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xFF181818),
          indicatorColor: Color(0xFF2A2A2A),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.white),
          ),
          iconTheme: WidgetStatePropertyAll(IconThemeData(color: Colors.white)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
