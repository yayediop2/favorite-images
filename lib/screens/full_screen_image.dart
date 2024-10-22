import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/platform_image.dart';

class FullScreenImage extends StatelessWidget {
  final XFile imageFile;

  const FullScreenImage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            panEnabled: false,
            boundaryMargin: const EdgeInsets.all(20),
            minScale: 0.5,
            maxScale: 4,
            child: PlatformImage(imageFile: imageFile),
          ),
        ),
      ),
    );
  }
}