import 'package:flutter/material.dart';

class MyComment {
  static Row comment() {
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
                      "2@test.com" + "  ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "2:59PM",
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
