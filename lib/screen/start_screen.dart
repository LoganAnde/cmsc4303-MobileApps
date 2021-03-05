import 'package:flutter/material.dart';
import 'package:lesson0/screen/counterdemo_screen.dart';
import 'package:lesson0/screen/formdemo_screen.dart';
import 'package:lesson0/screen/listdemo_screen.dart';
import 'package:lesson0/screen/listevent_screen.dart';
import 'package:lesson0/screen/colorselect_screen.dart';
import 'package:lesson0/screen/widgetlifecycle_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/startscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a menu'),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, ColorSelectScreen.routeName),
            child: Text(
              'Color Select Demo',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
