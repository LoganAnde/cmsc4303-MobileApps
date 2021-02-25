import 'package:flutter/material.dart';
import 'package:lesson0/model/user_record.dart';
import 'package:lesson0/screen/userhome_screen.dart';

class FormDemoScreen extends StatefulWidget {
  static const routeName = '/formDemoScreen';
  @override
  State<StatefulWidget> createState() {
    return _FormDemoState();
  }
}

class _FormDemoState extends State<FormDemoScreen> {
  _Controller con;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String error;
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
        title: Text('Form Demo'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Sign In, Please!',
                style: Theme.of(context).textTheme.headline5,
              ),
              error == null
                  ? SizedBox(
                      height: 1.0,
                    )
                  : Text(
                      error,
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: con.validateEmail,
                onSaved: con.saveEmail,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.security),
                  hintText: 'Enter Password',
                ),
                obscureText: true,
                autocorrect: false,
                validator: con.validatePassword,
                onSaved: con.savePassword,
              ),
              RaisedButton(
                onPressed: con.signIn,
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _FormDemoState state;
  _Controller(this.state);
  UserRecord userRecord = new UserRecord();

  void signIn() {
    if (!state.formKey.currentState.validate()) return;

    // Now validated
    state.formKey.currentState.save();
    // Lookup user DB

    var user =
        UserRecord.fakeDB.firstWhere((element) => element.email == userRecord.email && element.password == userRecord.password, orElse: () => null);

    if (user == null) {
      state.render(() => state.error = 'not valid user credential');
    } else {
      state.render(() => state.error = null);
      Navigator.pushNamed(state.context, UserHomeScreen.routeName, arguments: user);
    }
  }

  String validateEmail(String value) {
    if (value.contains('.') && value.contains('@')) return null;
    return 'not a valid email';
  }

  String validatePassword(String value) {
    if (value.length < 6) return 'too short';
    return null;
  }

  void saveEmail(String value) {
    userRecord.email = value;
  }

  void savePassword(String value) {
    userRecord.password = value;
  }
}
