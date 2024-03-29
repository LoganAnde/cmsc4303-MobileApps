import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson0/controller/firebasecontroller.dart';
import 'package:lesson0/model/constant.dart';
import 'package:lesson0/model/photomemo.dart';
import 'package:lesson0/screen/myView/mydialog.dart';
import 'package:lesson0/screen/signup_screen.dart';
import 'package:lesson0/screen/userhome_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signInScreen';

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignInScreen> {
  _Controller con;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'PhotoMemo',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 40.0),
                  ),
                ),
                Text(
                  'Sign in, please!',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: con.validateEmail,
                  onSaved: con.saveEmail,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                SizedBox(height: 15.0),
                RaisedButton(
                  onPressed: con.signUp,
                  child: Text(
                    'Create a new account',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _SignInState state;
  _Controller(this.state);
  String email;
  String password;

  String validateEmail(String value) {
    if (value.contains('@') && value.contains('.'))
      return null;
    else
      return 'invalid email address';
  }

  void saveEmail(String value) {
    email = value;
  }

  String validatePassword(String value) {
    if (value.length < 6)
      return 'too short';
    else
      return null;
  }

  void savePassword(String value) {
    password = value;
  }

  Future<void> signIn() async {
    if (!state.formKey.currentState.validate()) return;

    state.formKey.currentState.save();

    User user;
    MyDialog.circularProgressStart(state.context);
    try {
      user = await FirebaseController.signIn(email: email, password: password);
    } catch (e) {
      MyDialog.circularProgessStop(state.context);
      MyDialog.info(
        context: state.context,
        title: 'Sign In Error',
        content: e.toString(),
      );
      return;
    }

    try {
      List<PhotoMemo> photoMemoList = await FirebaseController.getPhotoMemoList(email: user.email);
      MyDialog.circularProgessStop(state.context);
      Navigator.pushNamed(
        state.context,
        UserHomeScreen.routeName,
        arguments: {Constant.ARG_USER: user, Constant.ARG_PHOTOMEMOLIST: photoMemoList},
      );
    } catch (e) {
      MyDialog.circularProgessStop(state.context);
      MyDialog.info(context: state.context, title: 'FireStore getPhotoMemoList error', content: '$e');
    }
  }

  void signUp() {
    // Navigate to sign up screen
    Navigator.pushNamed(state.context, SignUpScreen.routeName);
  }
}
