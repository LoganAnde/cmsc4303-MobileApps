import 'package:flutter/material.dart';

class FontScreen extends StatelessWidget {
  static const routeName = '/fontScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Font Demo'),
      ),
      body: Column(
        children: [
          Text('Font demo for mobile application dev class'),
          Text(
            'Font demo for mobile application dev class',
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'DankMono',
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            'Font demo for mobile application dev class',
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'IndieFlower',
            ),
          ),
        ],
      ),
    );
  }
}
