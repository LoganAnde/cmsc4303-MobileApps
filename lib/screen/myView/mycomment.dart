import 'package:flutter/material.dart';
import 'package:lesson0/model/comment.dart';
import 'package:lesson0/model/constant.dart';

class MyComment extends StatelessWidget {
  final Comment comment;
  final VoidCallback onDelete;
  final String currentUser;

  MyComment({@required this.comment, this.onDelete, @required this.currentUser}) {
    assert(comment != null);
  }

  @override
  Widget build(BuildContext context) {
    //static Row comment({@required Comment comment}) {
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
                Row(
                  children: [
                    Expanded(child: Text(comment.content)),
                    currentUser == comment.createdBy ? PopupMenuButton<String>(
                      onSelected: (value) => onDelete(),
                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        PopupMenuItem(
                          value: Constant.ACTION_DELETE,
                          child: Row(
                            children: [Icon(Icons.delete), Text(Constant.ACTION_DELETE)],
                          ),
                        ),
                      ],
                    ) : SizedBox(width: 1.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
