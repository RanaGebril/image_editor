import 'package:flutter/material.dart';
import 'package:image_projec/edit.dart';
import 'package:image_projec/home.dart';
import 'package:image_projec/provider/app_image_provider.dart';
import 'package:image_projec/splash_screen.dart';
import 'package:provider/provider.dart';

import 'filter_screen.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>AppImageProvider())
  ],
     child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
             fontSize: 22
          ),
          centerTitle: true,
          color: Colors.black,
          actionsIconTheme: IconThemeData(
            color: Colors.white
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        scaffoldBackgroundColor:  Color(0xff0e0d0d),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditScreen.routeName:(context)=>EditScreen(),
        FilterScreen.routeName:(context)=>FilterScreen()
      },
    );
  }
}
