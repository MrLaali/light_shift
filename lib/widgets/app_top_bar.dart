import 'package:flutter/material.dart';
import '../models/light_profile.dart';
import 'light_selector.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final LightProfile selectedLight;
  final ValueChanged<LightProfile?> onLightChanged;
  final List<LightProfile> lights;

  const AppTopBar({
    super.key,
    required this.selectedLight,
    required this.onLightChanged,
    required this.lights,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF181818),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 72,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Light Shift',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                LightSelector(
                  selectedLight: selectedLight,
                  lights: lights,
                  onChanged: onLightChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}