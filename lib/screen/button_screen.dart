import 'package:flutter/material.dart';

class ButtonScreen extends StatelessWidget {
  static const routeName = '/buttonScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Demo'),
      ),
      body: Text('button demo'),
    );
  }
}
