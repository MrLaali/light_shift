import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../data/light_profiles.dart';
import '../data/tested_color_loader.dart';
import '../models/light_profile.dart';
import '../models/tested_color.dart';
import '../services/image_mapper.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/image_upload_zone.dart';

class ImageSimulationScreen extends StatefulWidget {
  const ImageSimulationScreen({super.key});

  @override
  State<ImageSimulationScreen> createState() => _ImageSimulationScreenState();
}

class _ImageSimulationScreenState extends State<ImageSimulationScreen> {
  LightProfile selectedLight = lightProfiles.first;
  late Future<List<TestedColor>> testedColorsFuture;

  Uint8List? originalImageBytes;
  Uint8List? simulatedImageBytes;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    testedColorsFuture = loadTestedColors();
  }

  Future<void> _pickImage(List<TestedColor> palette) async {
    final result = await FilePicker.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result == null || result.files.single.bytes == null) return;

    final bytes = result.files.single.bytes!;

    setState(() {
      originalImageBytes = bytes;
      isProcessing = true;
    });

    final mapped = await ImageMapper.mapImageToPalette(
      imageBytes: bytes,
      palette: palette,
      selectedLight: selectedLight.type,
    );

    setState(() {
      simulatedImageBytes = mapped;
      isProcessing = false;
    });
  }

  Future<void> _remapImage(List<TestedColor> palette) async {
    if (originalImageBytes == null) return;

    setState(() {
      isProcessing = true;
    });

    final mapped = await ImageMapper.mapImageToPalette(
      imageBytes: originalImageBytes!,
      palette: palette,
      selectedLight: selectedLight.type,
    );

    setState(() {
      simulatedImageBytes = mapped;
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TestedColor>>(
      future: testedColorsFuture,
      builder: (context, snapshot) {
        final palette = snapshot.data ?? [];

        return Scaffold(
          appBar: AppTopBar(
            selectedLight: selectedLight,
            lights: lightProfiles,
            onLightChanged: (light) {
              if (light != null) {
                setState(() {
                  selectedLight = light;
                });

                if (snapshot.hasData) {
                  _remapImage(palette);
                }
              }
            },
          ),
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            color: selectedLight.color,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                padding: const EdgeInsets.all(24),
                child: snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          ImageUploadZone(
                            onTap: () => _pickImage(palette),
                          ),
                          const SizedBox(height: 24),
                          if (isProcessing)
                            const LinearProgressIndicator(),
                          if (originalImageBytes != null &&
                              simulatedImageBytes != null)
                            Expanded(
                              child: _ImageComparison(
                                originalImageBytes: originalImageBytes!,
                                simulatedImageBytes: simulatedImageBytes!,
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ImageComparison extends StatelessWidget {
  final Uint8List originalImageBytes;
  final Uint8List simulatedImageBytes;

  const _ImageComparison({
    required this.originalImageBytes,
    required this.simulatedImageBytes,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    final children = [
      _ImagePanel(
        title: 'Original',
        imageBytes: originalImageBytes,
      ),
      _ImagePanel(
        title: 'Simulated',
        imageBytes: simulatedImageBytes,
      ),
    ];

    return isMobile
        ? Column(children: children)
        : Row(children: children);
  }
}

class _ImagePanel extends StatelessWidget {
  final String title;
  final Uint8List imageBytes;

  const _ImagePanel({
    required this.title,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xEE181818),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Image.memory(
                imageBytes,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}