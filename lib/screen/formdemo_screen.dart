import 'package:flutter/material.dart';

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
              Text('Sign In, Please', style: Theme.of(context).textTheme.headline5),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.security),
                  hintText: 'Enter Password',
                ),
                obscureText: true,
                autocorrect: false,
              ),
              RaisedButton(
                onPressed: null,
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
}
