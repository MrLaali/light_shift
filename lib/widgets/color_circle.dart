import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/light_profiles.dart';
import '../models/light_profile.dart';
import '../models/tested_color.dart';

class ColorCircle extends StatefulWidget {
  final TestedColor testedColor;
  final LightProfile selectedLight;

  const ColorCircle({
    super.key,
    required this.testedColor,
    required this.selectedLight,
  });

  @override
  State<ColorCircle> createState() => _ColorCircleState();
}

class _ColorCircleState extends State<ColorCircle> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final originalColor = widget.testedColor.colorFor(LightType.white);
    final displayColor = widget.testedColor.colorFor(widget.selectedLight.type);
    final visibleColor = isHovering ? originalColor : displayColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => ColorDetailsDialog(
              testedColor: widget.testedColor,
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: visibleColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isHovering ? Colors.white : Colors.transparent,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: isHovering ? 0.35 : 0.18,
                ),
                blurRadius: isHovering ? 22 : 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Removed duplicate ColorDetailsDialog (earlier variant). The remaining
// ColorDetailsDialog implementation below is used.

class ColorDetailsDialog extends StatelessWidget {
  final TestedColor testedColor;

  const ColorDetailsDialog({
    super.key,
    required this.testedColor,
  });

  String _hexFromColor(Color color) {
    final value = color.toARGB32() & 0xFFFFFF;
    return '#${value.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF181818),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Container(
        width: 900,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: lightProfiles.map((light) {
                  final color = testedColor.colorFor(light.type);
                  final hex = _hexFromColor(color);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _ColorDetailItem(
                      light: light,
                      color: color,
                      hex: hex,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorDetailItem extends StatelessWidget {
  final LightProfile light;
  final Color color;
  final String hex;

  const _ColorDetailItem({
    required this.light,
    required this.color,
    required this.hex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lightbulb_rounded,
            color: light.color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            light.name,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Clipboard.setData(
                ClipboardData(text: hex),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$hex copied'),
                  duration: const Duration(milliseconds: 1200),
                ),
              );
            },
            child: Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            hex,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
