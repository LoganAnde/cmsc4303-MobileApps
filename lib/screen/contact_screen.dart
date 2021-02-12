import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = '/contactScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Me'),
      ),
      body: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Comments',
                  icon: Icon(Icons.chat_bubble),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  print('Contact form submitted.');
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
