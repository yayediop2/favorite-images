import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageGalleryScreen(),
    );
  }
}

class ImageGalleryScreen extends StatefulWidget {
  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFiles = [];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        _imageFiles.add(selectedImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.camera),
                          title: Text('Take a picture'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.camera);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Choose from gallery'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: _imageFiles.isEmpty
          ? Center(child: Text('No images selected'))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _imageFiles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                          imageFile: _imageFiles[index],
                        ),
                      ),
                    );
                  },
                  child: Image.file(
                    File(_imageFiles[index].path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final XFile imageFile;

  const FullScreenImage({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            panEnabled: false,
            boundaryMargin: EdgeInsets.all(20),
            minScale: 0.5,
            maxScale: 4,
            child: Image.file(File(imageFile.path)),
          ),
        ),
      ),
    );
  }
}