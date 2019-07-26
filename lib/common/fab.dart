import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  Function click;

  FAB({this.click});

  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: this.click,
        child: Icon(Icons.add));
  }
}
