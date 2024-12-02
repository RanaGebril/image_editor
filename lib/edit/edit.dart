import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_projec/BottomNavigationItem.dart';
import 'package:image_projec/edit_provider.dart';
import 'package:provider/provider.dart';

import '../adjustments_widget.dart';

class EditScreen extends StatefulWidget {
  static String routeName = 'edit';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    var selectedImage = ModalRoute.of(context)?.settings.arguments as String;

    return ChangeNotifierProvider(
      create: (context) => EditProvider(),
      builder: (context, child) {
        var edit_provider = Provider.of<EditProvider>(context);
        return Scaffold(
          backgroundColor: const Color(0xff0e0d0d),
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Implement save functionality here
                },
                child: const Text('Save'),
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
                    onpressed: () async {
                      // Pass the image to be cropped
                      if (edit_provider.croppedImage != null) {
                        await edit_provider.cropImage(edit_provider.croppedImage!);
                      } else {
                        // If no cropped image, pass the selected image
                        await edit_provider.cropImage(File(selectedImage));
                      }
                    },
                    title: 'Crop & Rotate',
                    icon: Icons.crop_rotate,
                  ),
                  BottomNavigationItem(
                    onpressed: () {
                      edit_provider.toggleMirror();
                    },
                    title: 'Mirror',
                    icon: Icons.flip,
                  ),
                  BottomNavigationItem(
                    onpressed: () {
                      // Implement Resize functionality here
                    },
                    title: 'Resize',
                    icon: Icons.photo_size_select_large,
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Center(
                child: Container(
                  child: edit_provider.croppedImage != null
                      ? Image.file(
                    edit_provider.croppedImage!,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    fit: BoxFit.fill,
                  )
                      : Image.file(
                    File(selectedImage),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              AdjustmentsWidget(
                onBrightnessChanged: (brightness) {
                  // Handle brightness change
                },
                onContrastChanged: (contrast) {
                  // Handle contrast change
                },
                onBorderShapeChanged: (borderShape) {
                  // Handle border shape change
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
