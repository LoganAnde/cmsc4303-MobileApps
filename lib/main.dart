import 'package:flutter/material.dart';
import 'package:lesson0/screen/start_screen.dart';

void main() {
  runApp(Lesson1App());
}

class Lesson1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/startScreen',
      routes: {'/startScreen': gotoStart},
    );
  }
}

Widget gotoStart(BuildContext context) {
  return StartScreen();
}
