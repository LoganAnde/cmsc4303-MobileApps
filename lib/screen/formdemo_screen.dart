import 'package:flutter/material.dart';

class FormDemoScreen extends StatefulWidget {
  static const routeName = '/formDemoScreen';
  @override
  State<StatefulWidget> createState() {
    return _FormDemoState();
  }
}

class _FormDemoState extends State<FormDemoScreen> {
  _Controller con;
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
        title: Text('Form Demo'),
      ),
      body: Text('form demo'),
    );
  }
}

class _Controller {
  _FormDemoState state;
  _Controller(this.state);
}
