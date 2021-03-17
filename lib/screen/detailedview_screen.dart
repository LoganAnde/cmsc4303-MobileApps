import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson0/model/constant.dart';
import 'package:lesson0/model/photomemo.dart';

class DetailedViewScreen extends StatefulWidget {
  static const routeName = '/detailedViewScreen';
  @override
  State<StatefulWidget> createState() {
    return _DetailedViewState();
  }
}

class _DetailedViewState extends State<DetailedViewScreen> {
  _Controller con;
  User user;
  PhotoMemo onePhotoMemo;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    user ??= args[Constant.ARG_USER];
    onePhotoMemo ??= args[Constant.ARG_ONE_PHOTOMEMO];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed View'),
        actions: [
          editMode ? IconButton(icon: Icon(Icons.check), onPressed: con.update) : IconButton(icon: Icon(Icons.edit), onPressed: con.edit),
        ],
      ),
      body: Text(onePhotoMemo.imageLabels.join(' | ')),
    );
  }
}

class _Controller {
  _DetailedViewState state;
  _Controller(this.state);

  void update() {
    state.render(() => state.editMode = false);
  }

  void edit() {
    state.render(() => state.editMode = true);
  }
}
