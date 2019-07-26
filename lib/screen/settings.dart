import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Categories")));
  }
}
