import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson0/model/comment.dart';
import 'package:lesson0/model/constant.dart';
import 'package:lesson0/model/photomemo.dart';

import 'myView/mycomment.dart';
import 'myView/myimage.dart';

class CommentScreen extends StatefulWidget {
  static const routeName = '/commentScreen';

  @override
  State<StatefulWidget> createState() {
    return _CommentState();
  }
}

class _CommentState extends State<CommentScreen> {
  _Controller con;
  User user;
  PhotoMemo photoMemo;
  List<Comment> commentList;
  GlobalKey<FormState> commentFormKey = GlobalKey<FormState>();

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
    photoMemo ??= args[Constant.ARG_ONE_PHOTOMEMO];
    commentList ??= args[Constant.ARG_COMMENTLIST];

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments of Photomemo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: MyImage.network(context: context, url: photoMemo.photoURL),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Form(
              key: commentFormKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      enabled: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          ///////////////onPressed: con.addComment,
                          onPressed: null,
                        ),
                        hintText: 'Leave a comment...',
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      validator: Comment.validateComment,
                      //////////////onSaved: con.saveComment,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 55.0),
            Text(
              "Comments",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10.0),
            ListView.builder(
              // scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: commentList.length,
              itemBuilder: (BuildContext context, int index) => Container(
                child: MyComment.comment(
                  comment: commentList[index],
                ),
              ),
            ),
            SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _CommentState state;
  _Controller(this.state);
}