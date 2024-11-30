import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_projec/BottomNavigationItem.dart';
import 'package:image_projec/filters.dart';
import 'package:image_projec/model/Filter.dart';
import 'package:image_projec/provider/app_image_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class FilterScreen extends StatefulWidget {
  static String routeName = 'filter';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late Filter currentFilter;
  late List<Filter> filters;
  late AppImageProvider imageProvider;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    filters = Filters().list();
    currentFilter = filters[0];
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = ModalRoute.of(context)?.settings?.arguments as File;
    imageProvider.changeImage(imageFile);

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text('Filter'),
        actions: [
          IconButton(
            onPressed: () async {

              Uint8List? bytes = await screenshotController.capture();

              if (bytes != null) {

                final directory = await getApplicationDocumentsDirectory();
                final filePath = '${directory.path}/screenshot.png';
                final file = File(filePath);
                await file.writeAsBytes(bytes);

                imageProvider.changeImage(file);

                if (!mounted) return;

                Navigator.of(context).pop(); }
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: Center(
        child: Consumer<AppImageProvider>(
          builder: (context, value, Widget? child) {
            if (value.currentImage != null) {
              return Screenshot(
                controller: screenshotController,
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(currentFilter.matrix),
                  child: Image.memory(value.currentImage!),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 120,
        color: Colors.black,
        child: SafeArea(
          child: Consumer<AppImageProvider>(
            builder: (context, value, Widget? child) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length, // عدد الفلاتر
                itemBuilder: (context, index) {
                  Filter filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentFilter = filter;
                                });
                              },
                              child: ColorFiltered(
                                colorFilter: ColorFilter.matrix(filter.matrix),
                                child: Image.memory(
                                  value.currentImage!,
                                  fit: BoxFit.fill,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          filter.filterName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
