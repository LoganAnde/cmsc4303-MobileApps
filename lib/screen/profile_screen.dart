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
  UserRecord userRecordOriginal;
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
    userRecordOriginal ??= ModalRoute.of(context).settings.arguments;
    userRecord ??= UserRecord.clone(userRecordOriginal);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [editMode ? IconButton(icon: Icon(Icons.check), onPressed: con.update) : IconButton(icon: Icon(Icons.edit), onPressed: con.edit)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
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
                        validator: con.validateName,
                        onSaved: con.saveName,
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
                        validator: con.validatePhone,
                        onSaved: con.savePhone,
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
                        validator: con.validateAge,
                        onSaved: con.saveAge,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Classification',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(
                        color: Colors.blue[800],
                        width: 3.0,
                      )),
                  child: DropdownButtonFormField(
                    disabledHint: Text(
                      userRecord.classification.toString().split('.')[1],
                    ),
                    value: userRecord.classification,
                    items: con.getClassificationList(),
                    onChanged: editMode ? con.onChangedClassification : null,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Major',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.pink[50],
                      border: Border.all(
                        color: Colors.blue[800],
                        width: 3.0,
                      )),
                  child: Column(
                    children: con.getMajorRadioTitle(editMode),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Language Proficiency',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.teal[50],
                      border: Border.all(
                        color: Colors.blue[800],
                        width: 3.0,
                      )),
                  child: Column(
                    children: con.getLanguageCheckboxes(editMode),
                  ),
                )
              ],
            ),
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
    if (!state.formKey.currentState.validate()) return;

    state.formKey.currentState.save();
    state.userRecordOriginal.assign(state.userRecord);

    state.render(() => state.editMode = false);
  }

  String validateName(String value) {
    if (value.length < 2) {
      return 'min 2 chars';
    } else {
      return null;
    }
  }

  void saveName(String value) {
    state.userRecord.name = value;
  }

  String validatePhone(String value) {
    if (int.tryParse(value) == null)
      return 'digits only';
    else if (value.length < 4)
      return 'min 4 digits';
    else
      return null;
  }

  void savePhone(String value) {
    state.userRecord.phone = value;
  }

  String validateAge(String value) {
    try {
      int age = int.parse(value);
      if (age >= 5)
        return null;
      else
        return 'Min age 5';
    } catch (e) {
      return 'Not valid age';
    }
  }

  void saveAge(String value) {
    state.userRecord.age = int.parse(value);
  }

  List getClassificationList() {
    return Classification.values
        .map((c) => DropdownMenuItem(
              child: Text(c.toString().split('.')[1]),
              value: c,
            ))
        .toList();
  }

  void onChangedClassification(Classification c) {
    state.render(() => state.userRecord.classification = c);
  }

  List getMajorRadioTitle(bool editMode) {
    return Major.values
        .map((m) => RadioListTile(
              title: Text(m.toString().split('.')[1]),
              dense: true,
              value: m,
              groupValue: state.userRecord.major,
              onChanged: editMode
                  ? (Major value) {
                      state.render(() => state.userRecord.major = value);
                    }
                  : null,
            ))
        .toList();
  }

  List getLanguageCheckboxes(bool editMode) {
    return Language.values
        .map(
          (e) => CheckboxListTile(
            value: state.userRecord.languages[e],
            title: Text(e.toString().split('.')[1]),
            onChanged: editMode
                ? (bool value) {
                    state.render(() => state.userRecord.languages[e] = value);
                  }
                : null,
          ),
        )
        .toList();
  }
}
