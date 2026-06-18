import 'package:flutter/material.dart';
import '../models/light_profile.dart';

class LightSelector extends StatelessWidget {
  final LightProfile selectedLight;
  final List<LightProfile> lights;
  final ValueChanged<LightProfile?> onChanged;

  const LightSelector({
    super.key,
    required this.selectedLight,
    required this.lights,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.only(left: 16, right: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LightProfile>(
          value: selectedLight,
          dropdownColor: const Color(0xFF242424),
          borderRadius: BorderRadius.circular(18),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white70,
            size: 24,
          ),
          selectedItemBuilder: (context) {
            return lights.map((light) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lightbulb_rounded,
                    color: light.color,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    light.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }).toList();
          },
          items: lights.map((light) {
            return DropdownMenuItem<LightProfile>(
              value: light,
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_rounded,
                    color: light.color,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    light.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}