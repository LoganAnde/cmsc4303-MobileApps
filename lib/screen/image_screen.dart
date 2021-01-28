import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/imageScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Demo Screen'),
      ),
      body: ListView(
        children: [
          Container(
            height: 200.0,
            color: Colors.blueAccent,
            child: Image.network('https://m.media-amazon.com/images/I/71BKV6gMx5L._AC_UY218_.jpg'),
          ),
          Icon(
            Icons.ac_unit,
            size: 100,
            color: Colors.red,
          ),
          Container(
            height: 200.0,
            color: Colors.teal,
            child: Image.network('https://m.media-amazon.com/images/I/71yHsyWh4-L._AC_UY218_.jpg'),
          ),
          Icon(
            Icons.system_update,
            size: 200,
            color: Colors.pink,
          ),
          Container(
            height: 150.0,
            color: Colors.yellow[100],
            child: Image.asset('images/airplane.jpg'),
          )
        ],
      ),
    );
  }
}
