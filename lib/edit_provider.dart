import 'dart:io';
import 'dart:typed_data';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;


class EditProvider extends ChangeNotifier {

  File? croppedImage;
  Uint8List?  currentImage;
  File? originalImage; // Store the original image
  bool isMirrored = false; // Track mirroring state

  void setOriginalImage(File image) {
    originalImage = image;
    croppedImage = image; // Initially set croppedImage to original
    notifyListeners();
  }

  // Set the filtered or cropped image
  void setCroppedImage(File image) {
    croppedImage = image;
    notifyListeners();  // Notify listeners after updating the image
  }

  void setFilteredImage(File filteredImage) {
    croppedImage = filteredImage;
    notifyListeners();  // Notify listeners so the UI updates with the filtered image
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



  changeImage(File image) async {
    currentImage = await image.readAsBytes(); // تحويل ملف الصورة إلى Uint8List
    setFilteredImage(image);
  }
    notifyListeners();
  }


  // Future<void> toggleMirror() async {
  //   if (croppedImage != null) {
  //     final imageBytes = croppedImage!.readAsBytesSync();
  //     final img.Image? originalImageData = img.decodeImage(imageBytes);
  //
  //     if (originalImageData != null) {
  //       // Flip the image horizontally
  //       final mirroredImage = img.flipHorizontal(originalImageData);
  //
  //       final mirroredFile = File('${Directory.systemTemp.path}/mirrored_image.jpg')
  //         ..writeAsBytesSync(img.encodeJpg(mirroredImage));
  //
  //       setCroppedImage(mirroredFile);
  //       isMirrored = !isMirrored; // Toggle the mirroring state
  //     } else {
  //       debugPrint("Failed to decode image.");
  //     }
  //   } else {
  //     debugPrint("No image available to mirror.");
  //   }
  // }

