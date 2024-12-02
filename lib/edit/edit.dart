import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_projec/BottomNavigationItem.dart';
import 'package:image_projec/edit/filter/filter_screen.dart';
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
    // Retrieve the selected image path passed via the Navigator
    final selectedImage = ModalRoute.of(context)?.settings.arguments as String;

    return ChangeNotifierProvider(
      create: (context) => EditProvider(),
      child: Consumer<EditProvider>(  // Use Consumer to get the provider's state
        builder: (context, editProvider, child) {
          // Initialize the original image when the provider is created
          if (editProvider.originalImage == null) {
            editProvider.setOriginalImage(File(selectedImage));
          }

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
                        if (editProvider.croppedImage != null) {
                          await editProvider.cropImage(editProvider.croppedImage!);
                        } else {
                          // If no cropped image, pass the selected image
                          await editProvider.cropImage(File(selectedImage));
                        }
                      },
                      title: 'Crop & Rotate',
                      Icons.crop_rotate,
                    ),
                    BottomNavigationItem(
                      onpressed: () {
                       // editProvider.toggleMirror();
                      },
                      title: 'Mirror',
                       Icons.flip,
                    ),
                    BottomNavigationItem(
                      onpressed: () {
                        final imageFile = editProvider.croppedImage ?? File(selectedImage);
                        Navigator.pushNamed(
                          context,
                          FilterScreen.routeName,
                          arguments: imageFile, // Pass a File object
                        );
                      },
                      title: 'Filters',
                       Icons.filter_vintage_outlined,
                    ),
                  ],
                ),
              ),
            ),
            body: Center(
              child: Consumer<EditProvider>(
                builder: (context, editProvider, child) {
                  // Display the currently edited image (cropped or filtered image)
                  final displayImage = editProvider.croppedImage ?? File(selectedImage);

                  return Container(
                    child: Image.file(
                      displayImage,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),


          );
        },
      ),
    );
  }
}
