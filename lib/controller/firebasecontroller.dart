import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lesson0/model/comment.dart';
import 'package:lesson0/model/constant.dart';
import 'package:lesson0/model/photomemo.dart';

class FirebaseController {
  static Future<User> signIn({@required String email, @required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  static Future<void> createAccount({@required String email, @required String password}) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<Map<String, String>> uploadPhotoFile({
    @required File photo,
    String filename,
    @required String uid,
    @required Function listener,
  }) async {
    filename ??= '${Constant.PHOTOIMAGE_FOLDER}/$uid/${DateTime.now()}'; // new photomemo
    UploadTask task = FirebaseStorage.instance.ref(filename).putFile(photo);
    task.snapshotEvents.listen((TaskSnapshot event) {
      double progress = event.bytesTransferred / event.totalBytes;
      if (event.bytesTransferred == event.totalBytes) progress = null;
      listener(progress);
    });
    await task;
    String downloadURL = await FirebaseStorage.instance.ref(filename).getDownloadURL();
    return <String, String>{
      Constant.ARG_DOWNLOADURL: downloadURL,
      Constant.ARG_FILENAME: filename,
    };
  }

  static Future<String> addPhotoMemo(PhotoMemo photoMemo) async {
    var ref = await FirebaseFirestore.instance.collection(Constant.PHOTOMEMO_COLLECTION).add(photoMemo.serialize());
    return ref.id;
  }

  static Future<List<PhotoMemo>> getPhotoMemoList({@required String email}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.PHOTOMEMO_COLLECTION)
        .where(PhotoMemo.CREATED_BY, isEqualTo: email)
        .orderBy(PhotoMemo.TIMESTAMP, descending: true)
        .get();

    var result = <PhotoMemo>[];
    querySnapshot.docs.forEach((doc) {
      result.add(PhotoMemo.deserialize(doc.data(), doc.id));
    });
    return result;
  }

  static Future<List<dynamic>> getImageLabelsByContent({@required File photoFile}) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(photoFile);
    final ImageLabeler cloudLabeler = FirebaseVision.instance.cloudImageLabeler();
    final List<ImageLabel> cloudLabels = await cloudLabeler.processImage(visionImage);
    List<dynamic> labels = <dynamic>[];
    for (ImageLabel label in cloudLabels) {
      if (label.confidence >= Constant.MIN_ML_CONFIDENCE) {
        labels.add(label.text.toLowerCase());
      }
    }
    return labels;
  }

  static Future<List<dynamic>> getImageLabelsByText({@required File photoFile}) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(photoFile);
    final TextRecognizer textRecognizer = FirebaseVision.instance.cloudTextRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    List<dynamic> labels = <dynamic>[];
    for (TextBlock block in visionText.blocks) {
      labels.add(block.text.toString().toLowerCase().replaceAll('\n', ''));
    }
    return labels;
  }

  static Future<void> updatePhotoMemo(String docId, Map<String, dynamic> updateInfo) async {
    await FirebaseFirestore.instance.collection(Constant.PHOTOMEMO_COLLECTION).doc(docId).update(updateInfo);
  }

  static Future<List<PhotoMemo>> getPhotoMemoSharedWithMe({@required String email}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.PHOTOMEMO_COLLECTION)
        .where(PhotoMemo.SHARED_WITH, arrayContains: email)
        .orderBy(PhotoMemo.TIMESTAMP, descending: true)
        .get();

    var result = <PhotoMemo>[];
    querySnapshot.docs.forEach((doc) {
      result.add(PhotoMemo.deserialize(doc.data(), doc.id));
    });
    return result;
  }

  static Future<void> deletePhotoMemo(PhotoMemo p) async {
    // Delete firestore Document
    await FirebaseFirestore.instance.collection(Constant.PHOTOMEMO_COLLECTION).doc(p.docId).delete();

    // Delete the photo picture file
    await FirebaseStorage.instance.ref().child(p.photoFilename).delete();
  }

  static Future<List<PhotoMemo>> searchImage({
    @required String createdBy,
    @required List<String> searchLabels,
  }) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.PHOTOMEMO_COLLECTION)
        .where(PhotoMemo.CREATED_BY, isEqualTo: createdBy)
        .where(PhotoMemo.IMAGE_LABELS, arrayContainsAny: searchLabels)
        .orderBy(PhotoMemo.TIMESTAMP, descending: true)
        .get();
    var results = <PhotoMemo>[];
    querySnapshot.docs.forEach((doc) => results.add(PhotoMemo.deserialize(doc.data(), doc.id)));
    return results;
  }

  static Future<String> addComment(Comment comment) async {
    // Add comment to the comment collection
    var ref = await FirebaseFirestore.instance.collection(Constant.COMMENT_COLLECTION).add(comment.serialize());

    // Update the commentCount on photomemo doc
    await FirebaseFirestore.instance
        .collection(Constant.PHOTOMEMO_COLLECTION)
        .doc(comment.photoDocId)
        .update({PhotoMemo.COMMENTS_COUNT: FieldValue.increment(1)});

    return ref.id;
  }

  static Future<List<Comment>> getComments(String photoDocId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(Constant.COMMENT_COLLECTION)
        .where(Comment.PHOTODOCID, isEqualTo: photoDocId)
        .orderBy(Comment.TIMESTAMP, descending: true)
        .get();
    var results = <Comment>[];
    querySnapshot.docs.forEach((doc) => results.add(Comment.deserialize(doc.data(), doc.id)));
    return results;
  }

  static Future<void> deleteComment(Comment comment) async {
    // Delete firestore Document for the comment
    await FirebaseFirestore.instance.collection(Constant.COMMENT_COLLECTION).doc(comment.docId).delete();

    // Update the firestore doc for the PhotoMemo.commentsCount
    await FirebaseFirestore.instance
        .collection(Constant.PHOTOMEMO_COLLECTION)
        .doc(comment.photoDocId)
        .update({PhotoMemo.COMMENTS_COUNT: FieldValue.increment(-1)});
  }
}
