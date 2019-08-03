import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String title, content;

  MessageBox({this.title, this.content});

  Widget build(BuildContext context) {
    return AlertDialog(title: Text(title), content: Text(content), actions: [
      FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          })
    ]);
  }
}
