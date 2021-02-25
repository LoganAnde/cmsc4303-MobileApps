import 'package:flutter/material.dart';
import 'package:lesson0/screen/counterdemo_screen.dart';
import 'package:lesson0/screen/formdemo_screen.dart';
import 'package:lesson0/screen/listdemo_screen.dart';
import 'package:lesson0/screen/listevent_screen.dart';
import 'package:lesson0/screen/profile_screen.dart';
import 'package:lesson0/screen/start_screen.dart';
import 'package:lesson0/screen/userhome_screen.dart';
import 'package:lesson0/screen/widgetlifecycle_screen.dart';

void main() {
  runApp(Lesson2App());
}

class Lesson2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        CounterDemoScreen.routeName: (context) => CounterDemoScreen(),
        WidgetLifeCycleScreen.routeName: (context) => WidgetLifeCycleScreen(),
        ListDemoScreen.routeName: (context) => ListDemoScreen(),
        ListEventScreen.routeName: (context) => ListEventScreen(),
        FormDemoScreen.routeName: (context) => FormDemoScreen(),
        UserHomeScreen.routeName: (context) => UserHomeScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
      },
    );
  }
}
