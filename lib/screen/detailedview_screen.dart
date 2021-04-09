import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lesson0/controller/firebasecontroller.dart';
import 'package:lesson0/model/comment.dart';
import 'package:lesson0/model/constant.dart';
import 'package:lesson0/model/photomemo.dart';
import 'package:lesson0/screen/myView/mycomment.dart';
import 'package:lesson0/screen/myView/mydialog.dart';
import 'package:lesson0/screen/myView/myimage.dart';

class DetailedViewScreen extends StatefulWidget {
  static const routeName = '/detailedViewScreen';
  @override
  State<StatefulWidget> createState() {
    return _DetailedViewState();
  }
}

class _DetailedViewState extends State<DetailedViewScreen> {
  _Controller con;
  User user;
  PhotoMemo onePhotoMemoOriginal;
  PhotoMemo onePhotoMemoTemp;
  bool editMode = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> commentFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> sharedWithFormKey = GlobalKey<FormState>();
  String progressMessage;
  String comment;
  List<Comment> commentList;

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
    onePhotoMemoOriginal ??= args[Constant.ARG_ONE_PHOTOMEMO];
    onePhotoMemoTemp ??= PhotoMemo.clone(onePhotoMemoOriginal);
    commentList ??= args[Constant.ARG_COMMENTLIST];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed View'),
        actions: [
          editMode ? IconButton(icon: Icon(Icons.check), onPressed: con.update) : IconButton(icon: Icon(Icons.edit), onPressed: con.edit),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: con.photoFile == null
                            ? MyImage.network(context: context, url: onePhotoMemoTemp.photoURL)
                            : Image.file(con.photoFile, fit: BoxFit.fill),
                      ),
                      editMode
                          ? Positioned(
                              right: 0.0,
                              bottom: 0.0,
                              child: Container(
                                color: Colors.red[300],
                                child: PopupMenuButton<String>(
                                  onSelected: con.getPhoto,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: Constant.SRC_CAMERA,
                                      child: Row(children: [Icon(Icons.photo_camera), Text(Constant.SRC_CAMERA)]),
                                    ),
                                    PopupMenuItem(
                                      value: Constant.SRC_GALLERY,
                                      child: Row(children: [Icon(Icons.photo_library), Text(Constant.SRC_GALLERY)]),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(height: 1.0),
                    ],
                  ),
                  progressMessage == null ? SizedBox(height: 1.0) : Text(progressMessage, style: Theme.of(context).textTheme.headline6),
                  TextFormField(
                    enabled: editMode,
                    style: Theme.of(context).textTheme.headline6,
                    decoration: InputDecoration(
                      hintText: 'Enter Title',
                    ),
                    initialValue: onePhotoMemoTemp.title,
                    autocorrect: true,
                    validator: PhotoMemo.validateTitle,
                    onSaved: con.saveTitle,
                  ),
                  TextFormField(
                    enabled: editMode,
                    decoration: InputDecoration(
                      hintText: 'Enter Memo',
                    ),
                    initialValue: onePhotoMemoTemp.memo,
                    autocorrect: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    validator: PhotoMemo.validateMemo,
                    onSaved: con.saveMemo,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Form(
              key: sharedWithFormKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Add Shared With (email)',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.person_add),
                          onPressed: con.addSharedWith,
                        ),
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      validator: PhotoMemo.validateSharedWith,
                      onSaved: con.saveSharedWith,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 0.0, 60.0, 0.0),
              child: ListView.builder(
                itemCount: onePhotoMemoTemp.sharedWith.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => Container(
                  child: Row(
                    children: [
                      Text(onePhotoMemoTemp.sharedWith[index], style: TextStyle(fontSize: 16.0)),
                      Spacer(),
                      IconButton(icon: Icon(Icons.person_remove), onPressed: () => con.deleteSharedWith(index)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 55.0),
            Divider(),
            Constant.DEV ? Text('Image Labels generated by ML', style: Theme.of(context).textTheme.bodyText1) : SizedBox(height: 1.0),
            Constant.DEV ? Text(onePhotoMemoTemp.imageLabels.join(' | ')) : SizedBox(height: 1.0),
            Divider(),
            SizedBox(height: 10.0),
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
                          onPressed: con.addComment,
                        ),
                        hintText: 'Leave a comment...',
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      validator: Comment.validateComment,
                      onSaved: con.saveComment,
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
  _DetailedViewState state;
  _Controller(this.state);
  File photoFile; // camera or gallery

  Future<void> update() async {
    if (!state.formKey.currentState.validate()) return;

    state.formKey.currentState.save();
    try {
      MyDialog.circularProgressStart(state.context);
      Map<String, dynamic> updateInfo = {};
      if (photoFile != null) {
        Map photoInfo = await FirebaseController.uploadPhotoFile(
          photo: photoFile,
          filename: state.onePhotoMemoTemp.photoFilename,
          uid: state.user.uid,
          listener: (double message) {
            state.render(() {
              if (message == null)
                state.progressMessage = null;
              else {
                message *= 100;
                state.progressMessage = 'Uploading: ' + message.toStringAsFixed(1) + '%';
              }
            });
          },
        );

        state.onePhotoMemoTemp.photoURL = photoInfo[Constant.ARG_DOWNLOADURL];
        state.render(() => state.progressMessage = 'ML image labeler started');
        List<dynamic> labels = await FirebaseController.getImageLabels(photoFile: photoFile);
        state.onePhotoMemoTemp.imageLabels = labels;

        updateInfo[PhotoMemo.PHOTO_URL] = photoInfo[Constant.ARG_DOWNLOADURL];
        updateInfo[PhotoMemo.IMAGE_LABELS] = labels;
      }

      // determine which fields are updated
      if (state.onePhotoMemoOriginal.title != state.onePhotoMemoTemp.title) updateInfo[PhotoMemo.TITLE] = state.onePhotoMemoTemp.title;
      if (state.onePhotoMemoOriginal.memo != state.onePhotoMemoTemp.memo) updateInfo[PhotoMemo.MEMO] = state.onePhotoMemoTemp.memo;

      updateInfo[PhotoMemo.TIMESTAMP] = DateTime.now();
      await FirebaseController.updatePhotoMemo(state.onePhotoMemoTemp.docId, updateInfo);

      state.onePhotoMemoOriginal.assign(state.onePhotoMemoTemp);
      MyDialog.circularProgessStop(state.context);
      Navigator.pop(state.context);
    } catch (e) {
      MyDialog.circularProgessStop(state.context);
      MyDialog.info(context: state.context, title: 'Update PhotoMemo error', content: '$e');
    }
  }

  void edit() {
    state.render(() => state.editMode = true);
  }

  void getPhoto(String src) async {
    try {
      PickedFile _photoFile;
      if (src == Constant.SRC_CAMERA) {
        _photoFile = await ImagePicker().getImage(source: ImageSource.camera);
      } else {
        _photoFile = await ImagePicker().getImage(source: ImageSource.gallery);
      }
      if (_photoFile == null) return; // selection cancelled
      state.render(() => photoFile = File(_photoFile.path));
    } catch (e) {
      MyDialog.info(context: state.context, title: 'getPhoto error', content: '$e');
    }
  }

  void saveTitle(String value) {
    state.onePhotoMemoTemp.title = value;
  }

  void saveMemo(String value) {
    state.onePhotoMemoTemp.memo = value;
  }

  void saveSharedWith(String value) async {
    state.onePhotoMemoTemp.sharedWith.add(value);

    Map<String, dynamic> updateInfo = {};
    updateInfo[PhotoMemo.SHARED_WITH] = state.onePhotoMemoTemp.sharedWith;
    await FirebaseController.updatePhotoMemo(state.onePhotoMemoTemp.docId, updateInfo);

    // Clear input field
    this.state.sharedWithFormKey.currentState.reset();
    state.onePhotoMemoOriginal.assign(state.onePhotoMemoTemp);
  }

  void addSharedWith() {
    if (!state.sharedWithFormKey.currentState.validate()) return;

    this.state.sharedWithFormKey.currentState.save();
  }

  void deleteSharedWith(int index) {
    print('remove shared with: ' + index.toString());
  }

  void addComment() {
    if (!state.commentFormKey.currentState.validate()) return;

    this.state.commentFormKey.currentState.save();
  }

  Future<void> saveComment(String value) async {
    Comment tempComment = Comment();

    // Upload to Firestore
    MyDialog.circularProgressStart(state.context);
    try {
      Map args = ModalRoute.of(this.state.context).settings.arguments;
      PhotoMemo photoMemo = args[Constant.ARG_ONE_PHOTOMEMO];

      tempComment.content = value;
      tempComment.photoDocId = photoMemo.docId;
      tempComment.createdBy = state.user.email;
      tempComment.timestamp = DateTime.now();

      await FirebaseController.addComment(tempComment);

      state.commentList.insert(0, tempComment);

      MyDialog.circularProgessStop(state.context);
    } catch (e) {
      MyDialog.circularProgessStop(state.context);
      MyDialog.info(context: state.context, title: 'Save Comment error', content: '$e');
    }

    // Clear the input field
    this.state.commentFormKey.currentState.reset();

    ++state.onePhotoMemoTemp.commentsCount;
    state.onePhotoMemoOriginal.assign(state.onePhotoMemoTemp);
  }
}
