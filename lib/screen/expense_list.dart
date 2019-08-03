import 'package:flutter/material.dart';
import 'package:tracker/common/control.dart';
import 'package:tracker/common/fab.dart';
import 'package:tracker/model/entry.dart';
import 'package:tracker/model/type.dart';
import 'package:tracker/screen/settings.dart';
import 'package:tracker/util/db_helper.dart';

import 'add_expense.dart';
import 'categories.dart';
import 'dashboard.dart';

class ExpenseList extends StatefulWidget {
  State<StatefulWidget> createState() => ExpenseListState();
}

class ExpenseListState extends State<ExpenseList> {
  Iterable<Entry> entries = List<Entry>();
  DbHelper dbHelper = DbHelper();

  void initState() {
    getData();
    super.initState();
  }

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
        body: _body(),
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: Text("Expense Tracker",
                style: TextStyle(fontWeight: FontWeight.w300))));
  }

  ListView _body() {
    return ListView(
      children: _listItems(),
    );
  }

  List<Widget> _listItems() {
    return entries
        .map((Entry entry) => Control(Card(
            child: ListTile(
                leading: Column(children: [
                  CircleAvatar(
                      child: Icon(IconData(entry.category.icon,
                          fontFamily: "MaterialIcons"))),
                  Text(entry.category.name)
                ]),
                isThreeLine: false,
                trailing: Text(entry.date),
                title: Text(entry.name),
                subtitle: Text("\$ " + entry.amount.toString())))))
        .toList();
  }

  getData() async {
    await dbHelper.init();
    List<dynamic> data = await dbHelper.getEntriesByType(EntryType.expense);
    List<Entry> tempEntries = List<Entry>();
    for (var i = 0; i < data.length; i++) {
      tempEntries.add(Entry.fromObject(data[i]));
    }
    setState(() {
      entries = tempEntries;
    });
  }

  void _onAddClick() async {
    bool reload = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddExpense()));
    if (reload) getData();
  }
}
