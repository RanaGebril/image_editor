import 'package:flutter/material.dart';
import 'package:image_projec/edit/edit.dart';
import 'package:image_projec/edit/filter/filter_screen.dart';
import 'package:image_projec/home.dart';
import 'package:image_projec/splash_screen.dart';
import 'package:provider/provider.dart';
import 'edit_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProvider(),
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          EditScreen.routeName: (context) => EditScreen(),
          FilterScreen.routeName:(context)=>FilterScreen()

        },
      ),
    );
  }
}
