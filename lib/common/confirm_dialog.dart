import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  Function onConfirm;
  String title, description;

  ConfirmDialog({this.onConfirm, this.title, this.description});

  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(this.title),
        content: Text(this.description),
        actions: _actions(context));
  }

  Iterable<Widget> _actions(BuildContext context) {
    return [
      FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      FlatButton(
        child: Text("Yes"),
        onPressed: onConfirm,
      )
    ];
  }
}
