import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;  // أضف هذه الحزمة
import 'adjustments_widget.dart';

class EditScreen extends StatefulWidget {
  static String routeName = 'edit';

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late String selectedImagePath;
  double brightness = 0.0;
  double contrast = 1.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedImagePath = ModalRoute.of(context)?.settings.arguments as String;
  }

  // دالة لتطبيق التعديلات على الصورة
  Future<void> applyImageAdjustments(String imagePath, double brightness, double contrast) async {
    // تحميل الصورة من الملف
    img.Image image = img.decodeImage(File(imagePath).readAsBytesSync())!;

    // تطبيق التعديلات على السطوع والتباين
    image = img.adjustColor(image, brightness: brightness, contrast: contrast);

    // حفظ الصورة المعدلة أو عرضها
    File(imagePath)..writeAsBytesSync(img.encodeJpg(image));

    setState(() {
      // أعد تحميل الصورة بعد التعديل
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e0d0d),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Edit Photo'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // تطبيق التعديلات عند الضغط على Save
              applyImageAdjustments(selectedImagePath, brightness, contrast);
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: Column(
        children: [
          // عرض الصورة المعدلة
          Expanded(
            flex: 3,
            child: Image.file(
              File(selectedImagePath),
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.contain,
            ),
          ),
          // إضافة Adjustments Widget
          AdjustmentsWidget(
            onBrightnessChanged: (value) {
              setState(() {
                brightness = value;
              });
            },
            onContrastChanged: (value) {
              setState(() {
                contrast = value;
              });
            },
            onBorderShapeChanged: (shape) {
              print("Border Shape: $shape");
              // تطبيق شكل الحدود هنا
            },
          ),
        ],
      ),
    );
  }
}
