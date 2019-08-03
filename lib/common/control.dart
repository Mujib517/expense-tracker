import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  Widget child;

  Control(this.child);

  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10), child: child);
  }
}
