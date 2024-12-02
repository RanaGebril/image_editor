import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_projec/edit/edit.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? image;
  final picker = ImagePicker();

  void showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Image Source',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.camera_alt, size: 30),
                        onPressed: () async {
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.camera);
                          if (pickedFile != null) {
                            setState(() {
                              image = File(pickedFile.path);
                            });
                          }
                          Navigator.pop(context);
                        },
                      ),
                      Text('Camera')
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.photo, size: 30),
                        onPressed: () async {
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              image = File(pickedFile.path);
                            });
                          }
                          Navigator.pop(context);
                        },
                      ),
                      Text('Gallery')
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Editing App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null ? Image.file(image!) : Text('No Image Selected'),
            ElevatedButton(
              onPressed: () {
                showImageSourceBottomSheet();
              },
              child: Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: () {
                if (image != null) {
                  Navigator.pushNamed(
                    context,
                    EditScreen.routeName,
                    arguments: image!.path,
                  );
                }
              },
              child: Text('Edit Image'),
            ),
          ],
        ),
      ),
    );
  }
}
