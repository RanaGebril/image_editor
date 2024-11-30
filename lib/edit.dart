import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_projec/BottomNavigationItem.dart';
import 'package:image_projec/edit_provider.dart';
import 'package:provider/provider.dart';

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
                    onpressed: () {
                      edit_provider.rotate_image();
                    },
                    title: 'Rotate',
                    icon: Icons.rotate_left,
                  ),
                  BottomNavigationItem(
                    onpressed: () {
                    },
                    title: 'crop',
                    icon: Icons.crop,
                  ),
                  BottomNavigationItem(
                    onpressed: () {
                      // Add functionality for translation
                    },
                    title: 'Translate',
                    icon: Icons.enhance_photo_translate,
                  ),
                  BottomNavigationItem(
                    onpressed: () {
                      // Add functionality for resizing
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
                  child: Transform.rotate(
                    angle: edit_provider.rotation_angle, // Apply rotation angle
                    child: Image.file(
                      File(selectedImage),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
