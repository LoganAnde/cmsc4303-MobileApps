import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson0/controller/firebasecontroller.dart';
import 'package:lesson0/model/comment.dart';
import 'package:lesson0/model/constant.dart';
import 'package:lesson0/model/photomemo.dart';
import 'package:lesson0/screen/addphotomemo_screen.dart';
import 'package:lesson0/screen/detailedview_screen.dart';
import 'package:lesson0/screen/myView/mydialog.dart';
import 'package:lesson0/screen/sharedwith_screen.dart';

import 'myView/myImage.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = '/userHomeScreen';
  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeScreen> {
  _Controller con;
  User user;
  List<PhotoMemo> photoMemoList;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    photoMemoList ??= args[Constant.ARG_PHOTOMEMOLIST];
    return WillPopScope(
      onWillPop: () => Future.value(false), // Android System Back button disabled
      child: Scaffold(
        appBar: AppBar(
          // title: Text('User Home'),
          actions: [
            con.delIndex != null
                ? IconButton(icon: Icon(Icons.cancel), onPressed: con.cancelDelete)
                : Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            fillColor: Theme.of(context).backgroundColor,
                            filled: true,
                          ),
                          autocorrect: true,
                          onSaved: con.saveSearchKeyString,
                        ),
                      ),
                    ),
                  ),
            con.delIndex != null
                ? IconButton(icon: Icon(Icons.delete), onPressed: con.delete)
                : IconButton(icon: Icon(Icons.search), onPressed: con.search),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: Icon(Icons.person, size: 100.0),
                accountName: Text('Not Set'),
                accountEmail: Text(user.email),
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Shared With Me'),
                onTap: con.sharedWithMe,
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: null, // con.settings,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: con.signOut,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: con.addButton,
        ),
        body: photoMemoList.length == 0
            ? Text('No PhotoMemos Found', style: Theme.of(context).textTheme.headline5)
            : ListView.builder(
                itemCount: photoMemoList.length,
                itemBuilder: (BuildContext context, int index) => Container(
                  color: con.delIndex != null && con.delIndex == index ? Theme.of(context).highlightColor : Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    leading: MyImage.network(
                      url: photoMemoList[index].photoURL,
                      context: context,
                    ),
                    trailing: Wrap(
                      spacing: 5,
                      children: [
                        Text(photoMemoList[index].commentsCount.toString()),
                        Icon(Icons.mode_comment),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                    title: Text(photoMemoList[index].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(photoMemoList[index].memo.length >= 20 ? photoMemoList[index].memo.substring(0, 20) + '...' : photoMemoList[index].memo),
                        Text('Created By: ${photoMemoList[index].createdBy}'),
                        Text('Shared With: ${photoMemoList[index].sharedWith}'),
                        Text('Updated At: ${photoMemoList[index].timestamp}'),
                      ],
                    ),
                    onTap: () => con.onTap(index),
                    onLongPress: () => con.onLongPress(index),
                  ),
                ),
              ),
      ),
    );
  }
}

class _Controller {
  _UserHomeState state;
  _Controller(this.state);
  int delIndex;
  String keyString;

  void addButton() async {
    await Navigator.pushNamed(
      state.context,
      AddPhotoMemoScreen.routeName,
      arguments: {
        Constant.ARG_USER: state.user,
        Constant.ARG_PHOTOMEMOLIST: state.photoMemoList,
      },
    );
    state.render(() {}); // Re-render the Screen
  }

  void signOut() async {
    try {
      await FirebaseController.signOut();
    } catch (e) {
      // do nothing
    }
    Navigator.of(state.context).pop(); // close the drawer
    Navigator.of(state.context).pop(); // pop UserHomeScreen
  }

  void onTap(int index) async {
    if (delIndex != null) return;
    List<Comment> commentList = await FirebaseController.getComments(state.photoMemoList[index].docId);
    await Navigator.pushNamed(
      state.context,
      DetailedViewScreen.routeName,
      arguments: {
        Constant.ARG_USER: state.user,
        Constant.ARG_ONE_PHOTOMEMO: state.photoMemoList[index],
        Constant.ARG_COMMENTLIST: commentList,
      },
    );
    state.render(() {}); // refresh
  }

  void sharedWithMe() async {
    try {
      List<PhotoMemo> photoMemoList = await FirebaseController.getPhotoMemoSharedWithMe(email: state.user.email);
      await Navigator.pushNamed(state.context, SharedWithScreen.routeName, arguments: {
        Constant.ARG_USER: state.user,
        Constant.ARG_PHOTOMEMOLIST: photoMemoList,
      });
      Navigator.pop(state.context); // closes the drawer
    } catch (e) {
      MyDialog.info(context: state.context, title: 'get Shared PhotoMemo error', content: '$e');
    }
  }

  void onLongPress(int index) {
    if (delIndex != null) return;
    state.render(() => delIndex = index);
  }

  void cancelDelete() {
    state.render(() => delIndex = null);
  }

  void delete() async {
    try {
      PhotoMemo p = state.photoMemoList[delIndex];
      await FirebaseController.deletePhotoMemo(p);
      state.render(() {
        state.photoMemoList.removeAt(delIndex);
        delIndex = null;
      });
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Delete PhotoMemo error',
        content: '$e',
      );
    }
  }

  void saveSearchKeyString(String value) {
    keyString = value;
  }

  void search() async {
    state.formKey.currentState.save();
    var keys = keyString.split(',').toList();
    List<String> searchKeys = [];
    for (var k in keys) {
      if (k.trim().isNotEmpty) searchKeys.add(k.trim().toLowerCase());
    }

    try {
      List<PhotoMemo> results;
      if (searchKeys.isNotEmpty) {
        results = await FirebaseController.searchImage(createdBy: state.user.email, searchLabels: searchKeys);
      } else {
        results = await FirebaseController.getPhotoMemoList(email: state.user.email);
      }
      state.render(() => state.photoMemoList = results);
    } catch (e) {
      MyDialog.info(context: state.context, title: 'Search error', content: '$e');
    }
  }
}
