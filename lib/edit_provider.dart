import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier{
  double rotation_angle = 0; // Rotation angle in radians

  rotate_image() {
//convert from degrees to radian
    rotation_angle += 90 * (3.14 / 180); // Rotate by 90 degrees
    notifyListeners();
  }

  crop_image() {


    notifyListeners();
  }
}