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
  @override
  Widget build(BuildContext context) {
    userRecord = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
      ),
      body: Text(userRecord.toString()),
    );
  }
}
