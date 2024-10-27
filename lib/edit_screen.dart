import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_projec/bottom_navigation_item.dart';

class EditScreen extends StatelessWidget{
  static String routeName='edit';


  @override
  Widget build(BuildContext context) {
    var selectedImage=ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        backgroundColor: Color(0xff0e0d0d),
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          actions: [
            ElevatedButton(
                onPressed: (){},
                child: Text('Save'))
          ],
        ),
        bottomNavigationBar:Container(
          width: double.infinity,
          height: 130,
          color: Colors.black,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                BottomNavigationItem(
                  onpressed: (){},
                  title: 'resize',
                  icon: Icons.photo_size_select_large,
                ),
                BottomNavigationItem(  onpressed: (){},
                  title: 'Rotate',
                  icon: Icons.rotate_left,
                ),
                BottomNavigationItem(
                  onpressed: (){},
                  title: 'translate',
                  icon: Icons.enhance_photo_translate,
                ),
                BottomNavigationItem(
                  onpressed: (){},
                  title: 'resize',
                  icon: Icons.photo_size_select_large,),
                BottomNavigationItem(
                  onpressed: (){},
                  title: 'resize',
                  icon: Icons.photo_size_select_large,),
                BottomNavigationItem(
                  onpressed: (){},
                  title: 'resize',
                  icon: Icons.photo_size_select_large,),
                BottomNavigationItem(
                  onpressed: (){},
                  title: 'resize',
                  icon: Icons.photo_size_select_large,),
              ],
            ),
          ),
        ) ,
        body: Column(
            children: [
              // SizedBox(height: 80,),
              Center(
                child: Container(
                  child: Image.file(File(selectedImage),
                    width: MediaQuery.of(context).size.width*0.8,
                    height:  MediaQuery.of(context).size.height*0.4,
                    fit: BoxFit.fill,),
                ),
              ),
            ])
    );
  }
}