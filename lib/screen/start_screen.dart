import 'package:flutter/material.dart';
import 'package:lesson0/screen/boxdecoration_screen.dart';
import 'package:lesson0/screen/contact_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/startScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Menu'),
        actions: [
          IconButton(
              icon: Icon(Icons.alarm),
              onPressed: () {
                print('Alarm');
              }),
          IconButton(
              icon: Icon(Icons.message_sharp),
              onPressed: () {
                print('Message');
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Message'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, BoxDecorationScreen.routeName),
              child: Text('Box Decoration Demo'),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, ContactScreen.routeName),
              child: Text('Contact Me'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Floating action button');
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
        ],
        currentIndex: 0,
        onTap: (index) {
          print('Current index = $index');
        },
      ),
    );
  }
}
