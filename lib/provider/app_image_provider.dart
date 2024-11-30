import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class AppImageProvider extends ChangeNotifier{
  Uint8List?  currentImage;
  changeImage(File image) async {
    currentImage = await image.readAsBytes(); // تحويل ملف الصورة إلى Uint8List
    notifyListeners();
  }
}