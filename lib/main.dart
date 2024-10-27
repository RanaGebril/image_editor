import 'package:flutter/material.dart';
import 'package:image_projec/edit_screen.dart';
import 'package:image_projec/home_screen.dart';
import 'package:image_projec/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditScreen.routeName:(context)=>EditScreen(),
      },
    );
  }
}
