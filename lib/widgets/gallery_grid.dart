import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'platform_image.dart';

class GalleryGrid extends StatelessWidget { 
  final List<XFile> imageFiles;
  final Function(XFile) onImageTap;

  const GalleryGrid({
    super.key,
    required this.imageFiles,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    if (imageFiles.isEmpty) {
      return const Center(child: Text('No images selected'));
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth < 600 ? (screenWidth / 2) - 16 : 236.0;
    final double containerWidth = screenWidth - (screenWidth % itemWidth);
    final int columnCount = (containerWidth / itemWidth).floor();

    return Center(
      child: Container(
        width: containerWidth,
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: MasonryGridView.count(
          crossAxisCount: columnCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: imageFiles.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onImageTap(imageFiles[index]),
              child: Container(
                width: itemWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: PlatformImage(
                  imageFile: imageFiles[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}