import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
}
