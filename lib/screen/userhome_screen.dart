import 'package:flutter/material.dart';
import 'package:lesson0/model/user_record.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = '/userHomeScreen';
  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeScreen> {
  UserRecord userRecord;
  _Controller con;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  @override
  Widget build(BuildContext context) {
    userRecord = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home for ${userRecord.name}'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(userRecord.email),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: null,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: con.signOut,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Text(
            'Hi ${userRecord.name}',
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }
}

class _Controller {
  _UserHomeState state;
  _Controller(this.state);

  void signOut() {
    Navigator.of(state.context).pop(); // Close the drawer
    Navigator.of(state.context).pop(); // Pop Userhome scaffold
  }
}
