import 'package:flutter/material.dart';

class ButtonScreen extends StatelessWidget {
  static const routeName = '/buttonScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Float AB'),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () => print('raised button 1'),
            elevation: 30.0,
            child: Text(
              'Raised Button 1',
              style: Theme.of(context).textTheme.headline5,
            ),
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 30.0),
          ),
          RaisedButton.icon(
            onPressed: () => print('RaisedButton.icon'),
            icon: Icon(Icons.alarm_add),
            elevation: 20.0,
            label: Text('RaisedButton.icon', style: Theme.of(context).textTheme.headline5),
          ),
          FlatButton(
            onPressed: () => print('Flat Button'),
            child: Text('Flat Button', style: Theme.of(context).textTheme.headline5),
            color: Colors.teal[900],
            splashColor: Colors.teal[50],
          ),
          IconButton(
            icon: Icon(
              Icons.analytics,
              size: 50.0,
              color: Colors.yellow,
            ),
            onPressed: () => print('icon button'),
          )
        ],
      ),
    );
  }
}
