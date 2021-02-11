import 'package:flutter/material.dart';

class BoxDecorationScreen extends StatelessWidget {
  static const routeName = '/boxDecorScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Box Decoration'),
        ),
        body: ListView(
          children: [
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.blue[400],
                image: const DecorationImage(
                  image: AssetImage('images/hummingbird.jpg'),
                  fit: BoxFit.fitHeight,
                ),
                border: Border.all(
                  color: Colors.yellow[600],
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('images/hummingbird.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.green[600],
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('images/hummingbird.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.purple[600],
                  width: 8,
                ),
              ),
            ),
          ],
        ));
  }
}
