import 'package:flutter/material.dart';
import 'package:lesson0/screen/button_screen.dart';
import 'package:lesson0/screen/font_screen.dart';
import 'package:lesson0/screen/image_screen.dart';
import 'package:lesson0/screen/materialdesign_screen.dart';
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
        fontFamily: 'Lobster',
        primaryColor: Colors.red[700],
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30.0,
            color: Colors.yellow[900],
          ),
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
      },
    );
  }
}

Widget gotoStart(BuildContext context) {
  return StartScreen();
}
