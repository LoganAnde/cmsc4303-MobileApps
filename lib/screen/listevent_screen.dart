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
        actions: (con.selected != null)
            ? [
                IconButton(icon: Icon(Icons.delete), onPressed: con.delete),
                IconButton(icon: Icon(Icons.cancel), onPressed: con.cancel),
              ]
            : null,
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
  List<int> selected;
  final Color selectedColor = Colors.indigo[500];
  final Color unSelectedColor = Colors.indigo[200];

  Widget getTile(BuildContext context, int index) {
    return Container(
      color: (selected != null && selected.indexOf(index) >= 0) ? selectedColor : unSelectedColor,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(courseList[index].title),
        subtitle: Text(courseList[index].number),
        onTap: () {
          _onTap(context, index);
        },
        onLongPress: () {
          _longPress(context, index);
        },
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    if (selected == null) {
      showDetails(context, courseList[index]);
    } else {
      state.render(() {
        if (selected.indexOf(index) < 0) {
          selected.add(index);
        } else {
          // cancel the selected by longpressing again
          selected.removeWhere((value) => value == index);
          if (selected.length == 0) selected = null;
        }
      });
    }
  }

  void _longPress(BuildContext context, int index) {
    if (selected == null) {
      state.render(() {
        selected = [];
        selected.add(index);
      });
    } else {
      state.render(() {
        if (selected.indexOf(index) < 0) {
          selected.add(index);
        } else {
          // cancel the selected by longpressing again
          selected.removeWhere((value) => value == index);
          if (selected.length == 0) selected = null;
        }
      });
    }
  }

  void delete() {
    selected.sort(); // ascending order
    state.render(() {
      for (int i = selected.length - 1; i >= 0; i--) {
        courseList.removeAt(selected[i]);
      }
      selected = null;
    });
  }

  void cancel() {
    state.render(() => selected = null);
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
