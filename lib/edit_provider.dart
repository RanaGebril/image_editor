import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';

class EditProvider extends ChangeNotifier {
  File? croppedImage;
  Uint8List? currentImage;
  File? originalImage; // Store the original image
  bool isMirrored = false; // Track mirroring state

  // Set the original image and initialize croppedImage to the original image
  void setOriginalImage(File image) {
    originalImage = image;
    croppedImage = image; // Initially set croppedImage to original
    notifyListeners();
  }

  // Set the cropped image and notify listeners
  void setCroppedImage(File image) {
    croppedImage = image;
    notifyListeners();
  }

  // Set the filtered image and notify listeners
  void setFilteredImage(File filteredImage) {
    croppedImage = filteredImage;
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

  // Change the image (e.g., when applying a filter or changing the image)
  Future<void> changeImage(File image) async {
    currentImage = await image.readAsBytes(); // Convert image file to Uint8List
    setFilteredImage(image); // Set the filtered image
    notifyListeners(); // Notify listeners after changing the image
  }

  // Toggle the mirror effect on the cropped image
  void toggleMirror() {
    if (croppedImage != null) {
      final imageBytes = croppedImage!.readAsBytesSync();
      final img.Image? originalImage = img.decodeImage(imageBytes);

      if (originalImage != null) {
        final mirroredImage = img.flipHorizontal(originalImage);
        final mirroredFile = File('${Directory.systemTemp.path}/mirrored_image.jpg')
          ..writeAsBytesSync(img.encodeJpg(mirroredImage));

        setCroppedImage(mirroredFile); // Set the mirrored image
      }
    }
  }
}
