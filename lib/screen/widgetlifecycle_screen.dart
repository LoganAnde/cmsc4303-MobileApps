import 'package:flutter/material.dart';

class WidgetLifeCycleScreen extends StatefulWidget {
  static const routeName = '/widgetLifyCycleScreen';
  @override
  State<StatefulWidget> createState() {
    print('========== createState()');
    return _WidgetLifeCycleState();
  }
}

class _WidgetLifeCycleState extends State<WidgetLifeCycleScreen> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    print('========== initState(): reserve resources');
  }

  @override
  void dispose() {
    print('========== dispose(): release reserverd resources');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('========== build()');
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Life Cycle Demo'),
      ),
      body: Column(
        children: [
          Text('Count $count'),
          RaisedButton(
            onPressed: () {
              setState(() {
                ++count;
              });
            },
            child: Text('Up'),
          )
        ],
      ),
    );
  }
}
