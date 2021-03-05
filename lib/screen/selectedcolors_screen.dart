import 'package:flutter/material.dart';
import 'package:lesson0/model/color_item.dart';

class SelectedColorsScreen extends StatefulWidget {
  static const routeName = '/selectedColorsScreen';

  @override
  State<StatefulWidget> createState() {
    return _SelectedColorsState();
  }
}

class _SelectedColorsState extends State<SelectedColorsScreen> {
  _Controller con;

  @override
  void initState() {
    super.initState;
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    List<int> selectedColors = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Selected Colors'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: con.getSelectedColors(selectedColors),
        ),
      ),
    );
  }
}

class _Controller {
  _SelectedColorsState state;
  _Controller(this.state);

  List<Card> getSelectedColors(List<int> selected) {
    List<Card> cards = new List<Card>();
    selected.forEach((index) => {
          cards.add(Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Container(color: colorItemList[index].color, width: 60.0),
                  title: Text(colorItemList[index].name),
                  subtitle: Text(colorItemList[index].hex),
                )
              ],
            ),
          ))
        });
    return cards;
  }
}
