import 'package:flutter/material.dart';
import 'package:lesson0/model/color_item.dart';
import 'package:lesson0/model/user_record.dart';
import 'package:lesson0/screen/selectedcolors_screen.dart';

class ColorSelectScreen extends StatefulWidget {
  static const routeName = '/themescreen';

  @override
  State<StatefulWidget> createState() {
    return _ColorSelectState();
  }
}

class _ColorSelectState extends State<ColorSelectScreen> {
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
        title: Text('Color Select'),
      ),
      body: Column(
        children: [
          Container(
            height: 450.0,
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: colorItemList.length,
              itemBuilder: con.getColors,
            ),
          ),
          RaisedButton(
            onPressed: con.showSelected,
            child: Text('Review Order Selected'),
          )
        ],
      ),
    );
  }
}

class _Controller {
  _ColorSelectState state;
  _Controller(this.state);
  List<int> selected;
  final BoxDecoration selectedBorder = BoxDecoration(border: Border.all(color: Colors.yellow));
  final Border usSelectedBorder = null;

  Widget getColors(BuildContext context, int index) {
    return Container(
      //color: colorItemList[index].color,
      decoration: (selected != null && selected.indexOf(index) >= 0)
          ? BoxDecoration(
              border: Border.all(color: Colors.black, width: 3.0),
              color: colorItemList[index].color,
            )
          : BoxDecoration(
              border: Border.all(color: Colors.black, width: 3.0),
            ),
      child: GestureDetector(
        onTap: () {
          _onTap(context, index);
        },
        child: GridTile(
          child: Text(colorItemList[index].name),
          footer: Text(colorItemList[index].hex),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
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

  void showSelected() {
    Navigator.pushNamed(state.context, SelectedColorsScreen.routeName, arguments: selected);
  }
}
