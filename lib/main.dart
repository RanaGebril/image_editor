import 'package:flutter/material.dart';
import 'package:image_projec/edit.dart';
import 'package:image_projec/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditScreen.routeName:(context)=>EditScreen(),
      },
    );
  }
}
