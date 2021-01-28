import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/imageScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Demo Screen'),
      ),
      body: Text('Image'),
    );
  }
}
