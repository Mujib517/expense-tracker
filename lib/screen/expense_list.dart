import 'package:flutter/material.dart';
import 'package:tracker/common/fab.dart';
import 'package:tracker/screen/settings.dart';

import 'add_expense.dart';
import 'categories.dart';
import 'dashboard.dart';

class ExpenseList extends StatefulWidget {
  State<StatefulWidget> createState() => ExpenseListState();
}

class ExpenseListState extends State<ExpenseList> {
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new Drawer(
            child: new ListView(children: <Widget>[
          new DrawerHeader(
              child: Column(children: [
                Text("EXPENSE TRACKER"),
                Icon(Icons.account_circle, size: 70),
                Text("Hello You"),
              ]),
              decoration: new BoxDecoration(color: Colors.deepOrangeAccent)),
          new ListTile(
              title: new Text("Expenses"),
              leading: Icon(Icons.add),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (ctxt) => new AddExpense()));
              }),
          new ListTile(
              title: new Text("Dashboard"),
              leading: Icon(Icons.dashboard),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (ctxt) => new Dashboard()));
              }),
          new ListTile(
              title: new Text("Categories"),
              leading: Icon(Icons.category),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (ctxt) => new Categories()));
              }),
          new ListTile(
              title: new Text("Settings"),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (ctxt) => new Settings()));
              })
        ])),
        floatingActionButton: FAB(
          click: _onAddClick,
        ),
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: Text("Expense Tracker",
                style: TextStyle(fontWeight: FontWeight.w300))));
  }

  void _onAddClick() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddExpense()));
  }
}
