import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';

class EditProvider extends ChangeNotifier {
  File? croppedImage;
  bool isMirrored = false; // for mirror effect

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
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        toolbarColor: Colors.deepPurple,
        toolbarWidgetColor: Colors.white,
        activeControlsWidgetColor: Colors.deepPurple,
        cropFrameColor: Colors.white,
        cropGridColor: Colors.white,
      ),
    );

    if (croppedFile != null) {
      setCroppedImage(File(croppedFile.path)); // Set the cropped image result
    }
  }

  void toggleMirror() {
    if (croppedImage != null) {
      final imageBytes = croppedImage!.readAsBytesSync();
      final img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage != null) {
        final mirroredImage = img.flipHorizontal(originalImage);
        final mirroredFile = File('${Directory.systemTemp.path}/mirrored_image.jpg')
          ..writeAsBytesSync(img.encodeJpg(mirroredImage));

        setCroppedImage(mirroredFile);
      }
    }
  }
}
