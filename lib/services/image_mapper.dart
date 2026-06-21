import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

import '../models/light_profile.dart';
import '../models/tested_color.dart';
import 'color_matcher.dart';

class ImageMapper {
  static Future<Uint8List> mapImageToPalette({
    required Uint8List imageBytes,
    required List<TestedColor> palette,
    required LightType selectedLight,
  }) async {
    final image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception('Unable to decode image');
    }

    final resizedImage = img.copyResize(
      image,
      width: image.width > 700 ? 700 : image.width,
    );

    final Map<int, TestedColor> cache = {};

    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        final pixel = resizedImage.getPixel(x, y);

        final originalColor = Color.fromARGB(
          pixel.a.toInt(),
          pixel.r.toInt(),
          pixel.g.toInt(),
          pixel.b.toInt(),
        );

        final cacheKey =
            (originalColor.r * 255).round() << 16 |
            (originalColor.g * 255).round() << 8 |
            (originalColor.b * 255).round();

        final closest = cache.putIfAbsent(
          cacheKey,
          () => ColorMatcher.findClosestColor(
            targetColor: originalColor,
            palette: palette,
          ),
        );

        final mappedColor = closest.colorFor(selectedLight);

        resizedImage.setPixelRgba(
          x,
          y,
          (mappedColor.r * 255).round(),
          (mappedColor.g * 255).round(),
          (mappedColor.b * 255).round(),
          pixel.a.toInt(),
        );
      }
    }

    return Uint8List.fromList(
      img.encodePng(resizedImage),
    );
  }
}