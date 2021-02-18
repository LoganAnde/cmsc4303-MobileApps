import 'package:flutter/material.dart';
import 'package:lesson0/model/course.dart';

class ListDemoScreen extends StatefulWidget {
  static const routeName = '/listDemoScreen';
  @override
  State<StatefulWidget> createState() {
    return _ListDemoState();
  }
}

class _ListDemoState extends State<ListDemoScreen> {
  _Controller con;

  @override
  void initState() {
    super.initState;
    con = _Controller(this);
  }

  void render(fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Demo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: con.getCourseList(),
          ),
        ));
  }
}

class _Controller {
  _ListDemoState state;
  _Controller(this.state);

  List<Widget> getCourseList() {
    return courseList.map((course) {
      return Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        color: Colors.lime[400],
        elevation: 15.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Image.network(
                      course.imageURL,
                      height: 200.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(course.number, style: Theme.of(state.context).textTheme.headline5),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(course.title, style: Theme.of(state.context).textTheme.headline6),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: Text('Prereq: ${course.prereq}', style: Theme.of(state.context).textTheme.headline6),
            ),
          ],
        ),
      );
    }).toList();
  }
}
