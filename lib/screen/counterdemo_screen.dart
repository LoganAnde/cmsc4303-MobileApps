import 'package:flutter/material.dart';

class CounterDemoScreen extends StatefulWidget {
  static const routeName = '/counterDemoScreen';
  @override
  State<StatefulWidget> createState() {
    return _CounterDemoState();
  }
}

class _CounterDemoState extends State<CounterDemoScreen> {
  _Controller con;
  int count = 0;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Demo'),
      ),
      body: Column(
        children: [
          Text(
            'Counter = $count',
            style: Theme.of(context).textTheme.headline5,
          ),
          RaisedButton(
            onPressed: con.upCount,
            child: Text('Up', style: Theme.of(context).textTheme.headline5),
          ),
          RaisedButton(
            onPressed: con.downCount,
            child: Text('Down', style: Theme.of(context).textTheme.headline5),
          ),
        ],
      ),
    );
  }
}

class _Controller {
  _CounterDemoState state;

  _Controller(this.state);

  void upCount() {
    state.render(() {
      ++state.count;
    });
  }

  void downCount() {
    state.render(() {
      --state.count;
    });
  }
}
