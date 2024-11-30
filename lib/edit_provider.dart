import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;


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
  }

  void toggleMirror() {
    debugPrint("Toggle Mirror called.");

    if (croppedImage != null) {
      debugPrint("Cropped image found. Proceeding with mirroring.");

      final imageBytes = croppedImage!.readAsBytesSync();
      final img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage != null) {
        debugPrint("Image decoded successfully. Mirroring image...");
        final mirroredImage = img.flipHorizontal(originalImage);

        final mirroredFile = File('${Directory.systemTemp.path}/mirrored_image.jpg')
          ..writeAsBytesSync(img.encodeJpg(mirroredImage));

        setCroppedImage(mirroredFile);
        debugPrint("Mirrored image saved and updated.");
      } else {
        debugPrint("Failed to decode the image.");
      }
    } else {
      debugPrint("No cropped image available to mirror.");
    }
  }

}