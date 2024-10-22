import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformImage extends StatelessWidget {
  final XFile imageFile;
  final BoxFit? fit;

  const PlatformImage({
    super.key,
    required this.imageFile,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = kIsWeb
        ? Image.network(
            imageFile.path,
            fit: fit,
          )
        : Image.file(
            File(imageFile.path),
            fit: fit,
          );

    return imageWidget;
  }
}