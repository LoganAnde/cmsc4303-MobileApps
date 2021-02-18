import 'package:flutter/material.dart';
import 'package:lesson0/model/course.dart';

class ListEventScreen extends StatefulWidget {
  static const routeName = '/listEventScreen';
  @override
  State<StatefulWidget> createState() {
    return _ListEventState();
  }
}

class _ListEventState extends State<ListEventScreen> {
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
        title: Text('List Event Demo'),
      ),
      body: ListView.builder(
        itemCount: courseList.length,
        itemBuilder: con.getTile,
      ),
    );
  }
}

class _Controller {
  _ListEventState state;
  _Controller(this.state);

  Widget getTile(BuildContext context, int index) {
    return Container(
      color: Colors.indigo[200],
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(courseList[index].title),
        subtitle: Text(courseList[index].number),
        onTap: () {
          print('onTap: $index');
        },
        onLongPress: () {
          print('onLongPress: $index');
        },
      ),
    );
  }
}
