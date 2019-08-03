import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tracker/model/category.dart';
import 'package:tracker/model/type.dart';
import 'package:tracker/util/db_helper.dart';

import 'add_category.dart';

class Categories extends StatefulWidget {
  State<StatefulWidget> createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  Iterable<Category> categoryData;
  DbHelper _dbHelper = DbHelper();
  int count = 0;

  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            floatingActionButton: Fab(),
            appBar: AppBar(
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.attach_money), text: "Expense"),
                  Tab(icon: Icon(Icons.account_balance_wallet), text: "Income")
                ]),
                title: Text('Categories')),
            body: TabBarView(children: [_expense(), _income()])));
  }

  void getData() async {
    await _dbHelper.init();
    final data = await _dbHelper.getCategories();
    List<Category> categories = List<Category>();
    for (int i = 0; i < data.length; i++) {
      categories.add(Category.fromObject(data[i]));
    }

    setState(() {
      count = data.length;
      categoryData = categories;
    });
  }

  Widget _income() {
    return ListView(children: _getIncomeList());
  }

  Widget _expense() {
    return ListView(children: _getExpenseList());
  }

  List<Widget> _getIncomeList() {
    return _getFilteredItems(EntryType.income);
  }

  List<Widget> _getExpenseList() {
    return _getFilteredItems(EntryType.expense);
  }

  List<Widget> _getFilteredItems(int type) {
    List<Widget> widgets = new List<Widget>();
    if (categoryData != null) {
      Iterator<Category> iterator = categoryData.iterator;
      while (iterator.moveNext()) {
        Category cat = iterator.current;
        if (cat.type != type) continue;
        widgets.add(ListTile(
            leading: Icon(IconData(cat.icon, fontFamily: "MaterialIcons")),
            title: Text(cat.name),
            trailing: FlatButton.icon(
                onPressed: () {
                  onDelete(cat.id);
                },
                icon: Icon(Icons.delete, size: 15),
                label: Text(""))));
        widgets.add(Divider());
      }
    }
    return widgets;
  }

  void onDelete(int id) async {
    await _dbHelper.init();
    await _dbHelper.deleteCategory(id);
    getData();
  }

  Widget Fab() {
    return SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 25.0),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.account_balance_wallet),
              backgroundColor: Colors.green,
              label: 'Income Category',
              labelBackgroundColor: Colors.transparent,
              onTap: () => navigateToAddCategory(EntryType.income)),
          SpeedDialChild(
              child: Icon(Icons.monetization_on),
              backgroundColor: Colors.red,
              label: 'Expense Category',
              labelBackgroundColor: Colors.transparent,
              onTap: () => navigateToAddCategory(EntryType.expense))
        ]);
  }

  void navigateToAddCategory(int type) async {
    bool reload = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddCategory(type)));
    if (reload) getData();
  }
}
