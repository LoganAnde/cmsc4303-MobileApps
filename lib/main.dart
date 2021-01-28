import 'package:flutter/material.dart';
import 'package:lesson0/screen/materialdesign_screen.dart';
import 'package:lesson0/screen/start_screen.dart';

void main() {
  runApp(Lesson1App());
}

class Lesson1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StartScreen.routeName,
      routes: {
        //Anonymous functions using arrow function notation
        StartScreen.routeName: (context) => StartScreen(),
        MaterialDesignScreen.routeName: (context) => MaterialDesignScreen()
      },
    );
  }
}

Widget gotoStart(BuildContext context) {
  return StartScreen();
}
