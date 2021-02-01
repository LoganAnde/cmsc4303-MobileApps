import 'package:flutter/material.dart';
import 'package:lesson0/screen/button_screen.dart';
import 'package:lesson0/screen/font_screen.dart';
import 'package:lesson0/screen/image_screen.dart';
import 'package:lesson0/screen/materialdesign_screen.dart';

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
      body: Column(
        children: [
          RaisedButton(
            // Push() brings up a seperate window you can exit out of using the arrow
            onPressed: () => Navigator.pushNamed(context, MaterialDesignScreen.routeName),
            child: Text('Material Design Demo'),
          ),
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, ImageScreen.routeName),
            child: Text('Image Demo'),
          ),
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, ButtonScreen.routeName),
            child: Text('Button Demo'),
          ),
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, FontScreen.routeName),
            child: Text('Custom Font Demo'),
          )
        ],
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
