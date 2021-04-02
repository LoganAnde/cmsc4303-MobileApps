import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lesson0/screen/addphotomemo_screen.dart';
import 'package:lesson0/screen/comment_screen.dart';
import 'package:lesson0/screen/detailedview_screen.dart';
import 'package:lesson0/screen/sharedwith_screen.dart';
import 'package:lesson0/screen/signin_screen.dart';
import 'package:lesson0/screen/signup_screen.dart';
import 'package:lesson0/screen/userhome_screen.dart';

import 'model/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PhotoMemoApp());
}

class PhotoMemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: Constant.DEV,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.red[700]),
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
        UserHomeScreen.routeName: (context) => UserHomeScreen(),
        AddPhotoMemoScreen.routeName: (context) => AddPhotoMemoScreen(),
        DetailedViewScreen.routeName: (context) => DetailedViewScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        SharedWithScreen.routeName: (context) => SharedWithScreen(),
        CommentScreen.routeName: (context) => CommentScreen(),
      },
    );
  }
}
