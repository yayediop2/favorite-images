import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/image_picker_service.dart';
import '../widgets/image_picker_bottom_sheet.dart';
import '../widgets/gallery_grid.dart';
import 'full_screen_image.dart';

class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({super.key});
  @override
  ImageGalleryScreenState createState() => ImageGalleryScreenState();
}

class ImageGalleryScreenState extends State<ImageGalleryScreen> {
  // Using ValueNotifier to persist the list
  final ValueNotifier<List<XFile>> _imageFilesNotifier = ValueNotifier<List<XFile>>([]);
  final _imagePickerService = ImagePickerService();

  Future<void> _pickImage(ImageSource source) async {
    final selectedImage = await _imagePickerService.pickImage(source);
    if (selectedImage != null) {
      // Update the list through the ValueNotifier
      _imageFilesNotifier.value = [..._imageFilesNotifier.value, selectedImage];
    }
  }

  @override
  void dispose() {
    _imageFilesNotifier.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(223, 244, 44, 4),
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "❤️ img",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo_outlined),
            color: Colors.white,
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => ImagePickerBottomSheet(
                onCameraTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
                onGalleryTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<XFile>>(
        valueListenable: _imageFilesNotifier,
        builder: (context, imageFiles, child) {
          return GalleryGrid(
            imageFiles: imageFiles,
            onImageTap: (imageFile) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(imageFile: imageFile),
                ),
              );
            },
          );
        },
      ),
    );
  }
}