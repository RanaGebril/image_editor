import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier {

  File? croppedImage;

  // Set the cropped image
  void setCroppedImage(File image) {
    croppedImage = image;
    notifyListeners();
  }

  // Crop the image with custom UI settings
  Future<void> cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Custom Crop Image',
        // Custom title for toolbar
        initAspectRatio: CropAspectRatioPreset.original,
        // Default aspect ratio for cropping
        lockAspectRatio: false,
        toolbarColor: Colors.deepPurple,
        // Toolbar color
        toolbarWidgetColor: Colors.white,
        // Widget color in toolbar
        activeControlsWidgetColor: Colors.deepPurple,
        cropFrameColor: Colors.white,
        cropGridColor: Colors.white,

      ),
    );

    if (croppedFile != null) {
      setCroppedImage(File(croppedFile.path)); // Set the cropped image result
    }
  }}