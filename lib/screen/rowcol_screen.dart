import 'package:flutter/material.dart';

class RowColScreen extends StatelessWidget {
  static const routeName = '/rowColScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Row/Column Layout Demo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // horizontal axis
            // mainAxisAlignment: MainAxisAlignment.center, // vertical axis (not meaningful since wrapped in ScrollView)
            children: [
              Stack(
                children: [
                  Container(
                    height: 200.0,
                    width: 500.0,
                    color: Colors.teal[800],
                  ),
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    child: IconButton(icon: Icon(Icons.alarm), onPressed: null),
                  )
                ],
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 1', style: Theme.of(context).textTheme.headline3),
              ),
              Wrap(
                spacing: 20.0,
                runSpacing: 10.0,
                children: [
                  Container(
                    color: Colors.teal[900],
                    child: Text('Row 2-1', style: Theme.of(context).textTheme.headline3),
                  ),
                  Container(
                    color: Colors.teal[900],
                    child: Text('Row 2-2', style: Theme.of(context).textTheme.headline3),
                  ),
                  Container(
                    color: Colors.teal[900],
                    child: Text('Row 2-3', style: Theme.of(context).textTheme.headline3),
                  ),
                  Container(
                    color: Colors.teal[900],
                    child: Text('Row 2-4', style: Theme.of(context).textTheme.headline3),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Image.network('https://m.media-amazon.com/images/I/71BKV6gMx5L._AC_UY218_.jpg'),
                  ),
                  Expanded(
                    child: Image.asset('images/airplane.jpg'),
                  ),
                ],
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 3', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 4', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 1', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 2', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 3', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 4', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 1', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 2', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 3', style: Theme.of(context).textTheme.headline3),
              ),
              Container(
                color: Colors.teal[900],
                child: Text('Row 4', style: Theme.of(context).textTheme.headline3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
