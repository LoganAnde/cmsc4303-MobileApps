import 'package:flutter/material.dart';
import 'package:lesson0/model/user_record.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profileScreen';
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfileScreen> {
  _Controller con;
  UserRecord userRecord;
  bool editMode = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    userRecord = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [editMode ? IconButton(icon: Icon(Icons.check), onPressed: con.update) : IconButton(icon: Icon(Icons.edit), onPressed: con.edit)],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Name', style: Theme.of(context).textTheme.headline6),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      enabled: editMode,
                      initialValue: userRecord.name,
                      validator: null,
                      onSaved: null,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Phone', style: Theme.of(context).textTheme.headline6),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      enabled: editMode,
                      initialValue: userRecord.phone,
                      validator: null,
                      onSaved: null,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Age', style: Theme.of(context).textTheme.headline6),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      enabled: editMode,
                      initialValue: userRecord.age.toString(),
                      validator: null,
                      onSaved: null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _ProfileState state;
  _Controller(this.state);

  void edit() {
    state.render(() => state.editMode = true);
  }

  void update() {
    state.render(() => state.editMode = false);
  }
}
