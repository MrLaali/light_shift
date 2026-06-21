import 'package:flutter/material.dart';

class ImageUploadZone extends StatelessWidget {
  final VoidCallback onTap;

  const ImageUploadZone({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: const Color(0xFF202020),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFF303030),
            width: 2,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.upload_file_rounded,
                color: Colors.white70,
                size: 54,
              ),
              SizedBox(height: 16),
              Text(
                'Upload Image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}