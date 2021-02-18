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
          showDetails(context, courseList[index]);
        },
        onLongPress: () {
          print('onLongPress: $index');
        },
      ),
    );
  }

  void showDetails(BuildContext context, Course course) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.pink[50],
        title: Text(course.number),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close', style: Theme.of(context).textTheme.headline5),
          )
        ],
        content: Card(
          color: Colors.indigo[300],
          elevation: 15.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.network(course.imageURL),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        course.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Prereq: ${course.prereq}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
