import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_projec/BottomNavigationItem.dart';
import 'package:image_projec/filter_screen.dart'; // Import the image package for image manipulation
import 'package:provider/provider.dart';
import 'package:image_projec/provider/app_image_provider.dart';

class EditScreen extends StatefulWidget {
  static String routeName = 'edit';

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late File _selectedImage;
  Uint8List? _resizedImageBytes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the selected image passed from the previous screen
    final selectedImagePath = ModalRoute.of(context)?.settings?.arguments as String;
    _selectedImage = File(selectedImagePath);
  }

  // Function to resize the image
  void _resizeImage() {
    final originalImageBytes = _selectedImage.readAsBytesSync();
    img.Image? originalImage = img.decodeImage(originalImageBytes);

    if (originalImage != null) {
      // Resize the image (for example, to 175x250)
      img.Image resizedImage = img.copyResize(originalImage, width: 175, height: 250);

      // Convert the resized image back to Uint8List
      setState(() {
        _resizedImageBytes = Uint8List.fromList(img.encodePng(resizedImage));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              // Save functionality
            },
            child: Text('Save'),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 130,
        color: Colors.black,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BottomNavigationItem(
                onpressed: _resizeImage, // Call the resize function when the icon is clicked
                title: 'resize',
                Icons.photo_size_select_large,
              ),
              BottomNavigationItem(
                onpressed: () {}, // Other functionalities
                title: 'Rotate',
                Icons.rotate_left,
              ),
              BottomNavigationItem(
                onpressed: () {
                  Navigator.pushNamed(
                    context,
                    FilterScreen.routeName,
                    arguments: _selectedImage, // الصورة كملف File
                  );
                }, // Other functionalities
                title: 'Filters',
                Icons.filter_vintage_outlined,
              ),
              // Add other BottomNavigationItems here...
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Consumer<AppImageProvider>(
                builder: (context, value, Widget? child) {
                  return value.currentImage != null
                      ? Image.memory(
                    value.currentImage!,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.contain,
                  )
                      : Image.file(
                    _selectedImage,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.5,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


