import 'package:flutter/material.dart';

class ExpandedWidgetScreen extends StatelessWidget {
  static const routeName = '/expandedWidgetScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanded Widget'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.teal[700],
                  child: Text(
                    'A',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Image.asset('images/airplane.jpg'),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red[700],
                  child: Text(
                    'B',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.yellow[800],
              child: Text(
                'AA',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.teal[800],
              child: Text(
                'BB',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red[800],
              child: Text(
                'CC',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
