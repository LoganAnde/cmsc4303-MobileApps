import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson0/controller/firebasecontroller.dart';
import 'package:lesson0/model/comment.dart';
import 'package:lesson0/model/constant.dart';
import 'package:lesson0/model/photomemo.dart';
import 'package:lesson0/screen/myView/myimage.dart';

import 'comment_screen.dart';

class SharedWithScreen extends StatefulWidget {
  static const routeName = '/sharedWithScreen';
  @override
  State<StatefulWidget> createState() {
    return _SharedWithState();
  }
}

class _SharedWithState extends State<SharedWithScreen> {
  _Controller con;
  User user;
  List<PhotoMemo> photoMemoList;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared With Me'),
      ),
      body: photoMemoList.length == 0
          ? Text('No PhotoMemos shared with me', style: Theme.of(context).textTheme.headline5)
          : ListView.builder(
              itemCount: photoMemoList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => con.onTap(index),
                child: Card(
                  elevation: 7.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: MyImage.network(
                            url: photoMemoList[index].photoURL,
                            context: context,
                          ),
                        ),
                      ),
                      Text('Title: ${photoMemoList[index].title}', style: Theme.of(context).textTheme.headline6),
                      Text('Memo: ${photoMemoList[index].memo}'),
                      Text('Created By: ${photoMemoList[index].createdBy}'),
                      Text('Updated At: ${photoMemoList[index].timestamp}'),
                      Text('Shared With: ${photoMemoList[index].sharedWith}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(photoMemoList[index].commentsCount.toString()),
                          Icon(Icons.mode_comment),
                          Icon(Icons.keyboard_arrow_right, size: 40.0),
                        ],
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
  _SharedWithState state;
  _Controller(this.state);

  void onTap(int index) async {
    List<Comment> commentList = await FirebaseController.getComments(state.photoMemoList[index].docId);
    await Navigator.pushNamed(
      state.context,
      CommentScreen.routeName,
      arguments: {
        Constant.ARG_USER: state.user,
        Constant.ARG_ONE_PHOTOMEMO: state.photoMemoList[index],
        Constant.ARG_COMMENTLIST: commentList,
      },
    );
  }
}
