import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'platform_image.dart';

class GalleryGrid extends StatefulWidget {
  final List<XFile> imageFiles;
  final Function(XFile) onImageTap;

  const GalleryGrid({
    super.key,
    required this.imageFiles,
    required this.onImageTap,
  });

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  @override
  Widget build(BuildContext context) {
    if (widget.imageFiles.isEmpty) {
      return const Center(child: Text('No images selected'));
    }

    const double itemWidth = 236.0;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth - (screenWidth % itemWidth);
    final int columnCount = (containerWidth / itemWidth).floor();

    return Center(
      child: Container(
        width: containerWidth,
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: MasonryGridView.count(
            crossAxisCount: columnCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: widget.imageFiles.length,
            shrinkWrap: true, // Ensures the scroll view only occupies the space it needs
            physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => widget.onImageTap(widget.imageFiles[index]),
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
                    imageFile: widget.imageFiles[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
