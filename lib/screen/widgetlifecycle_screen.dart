import 'package:flutter/material.dart';

class WidgetLifeCycleScreen extends StatefulWidget {
  static const routeName = '/widgetLifyCycleScreen';
  @override
  State<StatefulWidget> createState() {
    return _WidgetLifeCycleState();
  }
}

class _WidgetLifeCycleState extends State<WidgetLifeCycleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Life Cycle Demo'),
      ),
      body: Text('Life Cycle'),
    );
  }
}
