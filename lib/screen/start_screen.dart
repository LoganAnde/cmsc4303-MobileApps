import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/startScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Menu'),
        actions: [
          IconButton(
              icon: Icon(Icons.alarm),
              onPressed: () {
                print('Alarm');
              }),
          IconButton(
              icon: Icon(Icons.message_sharp),
              onPressed: () {
                print('Message');
              })
        ],
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              print('Menu 1');
            },
            child: Text('Menu 1'),
          ),
          RaisedButton(
            onPressed: () {
              print('Menu 2');
            },
            child: Text('Menu 2'),
          ),
          Text('Third Menu')
        ],
      ),
    );
  }
}
