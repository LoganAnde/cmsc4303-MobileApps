import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lesson0/controller/firebasecontroller.dart';
import 'package:lesson0/model/constant.dart';
import 'package:lesson0/model/photomemo.dart';
import 'package:lesson0/screen/myView/mydialog.dart';

class AddPhotoMemoScreen extends StatefulWidget {
  static const routeName = '/addPhotoMemoScreen';
  @override
  State<StatefulWidget> createState() {
    return _AddPhotoMemoState();
  }
}

class _AddPhotoMemoState extends State<AddPhotoMemoScreen> {
  _Controller con;
  User user;
  List<PhotoMemo> photoMemoList;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> sharedWithFormKey = GlobalKey<FormState>();
  List<String> sharedWithList = List<String>();
  File photo;
  String progressMessage;

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
        title: Text('Add PhotoMemo'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: con.save,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: photo == null ? Icon(Icons.photo_library, size: 300) : Image.file(photo, fit: BoxFit.fill),
                        ),
                        Positioned(
                          right: 0.0,
                          bottom: 0.0,
                          child: Container(
                            color: Colors.blue[200],
                            child: PopupMenuButton<String>(
                              onSelected: con.getPhoto,
                              itemBuilder: (context) => <PopupMenuEntry<String>>[
                                PopupMenuItem(
                                  value: Constant.SRC_CAMERA,
                                  child: Row(
                                    children: [
                                      Icon(Icons.photo_camera),
                                      Text(Constant.SRC_CAMERA),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: Constant.SRC_GALLERY,
                                  child: Row(
                                    children: [
                                      Icon(Icons.photo_album),
                                      Text(Constant.SRC_GALLERY),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    progressMessage == null ? SizedBox(height: 1.0) : Text(progressMessage, style: Theme.of(context).textTheme.headline6),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                      autocorrect: true,
                      validator: PhotoMemo.validateTitle,
                      onSaved: con.saveTitle,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Memo',
                      ),
                      autocorrect: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      validator: PhotoMemo.validateMemo,
                      onSaved: con.saveMemo,
                    ),
                  ],
                ),
              ),
            ),
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
                itemCount: sharedWithList.length ==  null ? 0 : sharedWithList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => Container(
                  child: Row(
                    children: [
                      Text(sharedWithList[index], style: TextStyle(fontSize: 16.0)),
                      Spacer(),
                      IconButton(icon: Icon(Icons.person_remove), onPressed: () => con.deleteSharedWith(index)),
                    ],
                  ),
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
  _AddPhotoMemoState state;
  _Controller(this.state);
  PhotoMemo tempMemo = PhotoMemo();
  String labelOption;
  List<dynamic> imageLabels;

  void save() async {
    if (!state.formKey.currentState.validate()) return;
    state.formKey.currentState.save();

    MyDialog.circularProgressStart(state.context);

    try {
      Map photoInfo = await FirebaseController.uploadPhotoFile(
        photo: state.photo,
        uid: state.user.uid,
        listener: (double progress) {
          state.render(() {
            if (progress == null)
              state.progressMessage = null;
            else {
              progress *= 100;
              state.progressMessage = 'Uploading: ' + progress.toStringAsFixed(1) + '%';
            }
          });
        },
      );

      MyDialog.circularProgessStop(state.context);

      // Prompt user for how they want to generate labels
      labelOption = await MyDialog.twoOptions(
        context: state.context,
        content: 'How would you like to generate labels?',
        option1: 'By Image Content',
        option2: 'By Image Text',
      );

      MyDialog.circularProgressStart(state.context);
      // Image labels by Machine Learning (ML)
      state.render(() => state.progressMessage = 'ML Image Labeler Started!');

      if (labelOption == "By Image Content") {
        imageLabels = await FirebaseController.getImageLabelsByContent(photoFile: state.photo);
      } else {
        imageLabels = await FirebaseController.getImageLabelsByText(photoFile: state.photo);
      }
      state.render(() => state.progressMessage = null);

      tempMemo.photoFilename = photoInfo[Constant.ARG_FILENAME];
      tempMemo.photoURL = photoInfo[Constant.ARG_DOWNLOADURL];
      tempMemo.timestamp = DateTime.now();
      tempMemo.createdBy = state.user.email;
      tempMemo.imageLabels = imageLabels;
      tempMemo.commentsCount = 0;
      String docId = await FirebaseController.addPhotoMemo(tempMemo);
      tempMemo.docId = docId;
      state.photoMemoList.insert(0, tempMemo);

      MyDialog.circularProgessStop(state.context);
      Navigator.pop(state.context); // Return to UserHomeScreen
    } catch (e) {
      MyDialog.circularProgessStop(state.context);
      MyDialog.info(context: state.context, title: 'Save PhotoMemo error', content: '$e');
    }
  }

  void getPhoto(String src) async {
    try {
      PickedFile _imageFile;
      var _picker = ImagePicker();
      if (src == Constant.SRC_CAMERA) {
        _imageFile = await _picker.getImage(source: ImageSource.camera);
      } else {
        _imageFile = await _picker.getImage(source: ImageSource.gallery);
      }
      if (_imageFile == null) return; // selection cancelled
      state.render(() => state.photo = File(_imageFile.path));
    } catch (e) {
      MyDialog.info(context: state.context, title: 'Failed to get picture', content: '$e');
    }
  }

  void saveTitle(String value) {
    tempMemo.title = value;
  }

  void saveMemo(String value) {
    tempMemo.memo = value;
  }

  void saveSharedWith(String value) {
    state.sharedWithList.add(value);
    tempMemo.sharedWith.add(value);

    // Clear input field
    this.state.sharedWithFormKey.currentState.reset();
    state.render(() {});
  }

  void addSharedWith() {
    if (!state.sharedWithFormKey.currentState.validate()) return;

    this.state.sharedWithFormKey.currentState.save();
  }

  void deleteSharedWith(int index) async {
    state.sharedWithList.removeAt(index);
    tempMemo.sharedWith.removeAt(index);
    state.render(() {});
  }
}
