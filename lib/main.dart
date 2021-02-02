import 'package:flutter/material.dart';
import 'package:lesson0/screen/button_screen.dart';
import 'package:lesson0/screen/font_screen.dart';
import 'package:lesson0/screen/image_screen.dart';
import 'package:lesson0/screen/materialdesign_screen.dart';
import 'package:lesson0/screen/rowcol_screen.dart';
import 'package:lesson0/screen/start_screen.dart';

void main() {
  runApp(Lesson1App());
}

class Lesson1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'IndieFlower',
        primaryColor: Colors.red[700],
        textTheme: TextTheme(
          button: TextStyle(fontFamily: 'Lobster', fontSize: 28.0),
        ),
      ),
      initialRoute: StartScreen.routeName,
      routes: {
        //Anonymous functions using arrow function notation
        StartScreen.routeName: (context) => StartScreen(),
        MaterialDesignScreen.routeName: (context) => MaterialDesignScreen(),
        ImageScreen.routeName: (context) => ImageScreen(),
        ButtonScreen.routeName: (context) => ButtonScreen(),
        FontScreen.routeName: (context) => FontScreen(),
        RowColScreen.routeName: (context) => RowColScreen(),
      },
    );
  }
}

Widget gotoStart(BuildContext context) {
  return StartScreen();
}
