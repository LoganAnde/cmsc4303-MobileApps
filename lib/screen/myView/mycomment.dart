import 'package:flutter/material.dart';
import 'package:lesson0/model/comment.dart';

class MyComment {
  static Row comment({@required Comment comment}) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      comment.createdBy + "  ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      comment.timestamp.toString(),
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Text(comment.content),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
