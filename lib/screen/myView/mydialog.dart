import 'package:flutter/material.dart';

class MyDialog {
  static void circularProgressStart(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 10.0,
        ),
      ),
    );
  }

  static void circularProgessStop(BuildContext context) {
    Navigator.pop(context);
  }

  static void info({
    @required BuildContext context,
    @required String title,
    @required String content,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
    );
  }

  static Future<String> twoOptions({
    @required BuildContext context,
    @required String content,
    @required String option1,
    @required String option2,
  }) async {
    String selected;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text(content),
        actions: [
          FlatButton(
            onPressed: () {
              selected = option1;
              Navigator.of(context).pop();
            },
            child: Text(option1, style: Theme.of(context).textTheme.button),
          ),
          FlatButton(
            onPressed: () {
              selected = option2;
              Navigator.of(context).pop();
            },
            child: Text(option2, style: Theme.of(context).textTheme.button),
          ),
        ],
      ),
    );

    return selected;
  }
}
