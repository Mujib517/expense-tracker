import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Dashboards")));
  }
}
