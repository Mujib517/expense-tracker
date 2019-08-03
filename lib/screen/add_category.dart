import 'package:flutter/material.dart';
import 'package:tracker/common/control.dart';
import 'package:tracker/common/input_box.dart';
import 'package:tracker/model/category.dart';
import 'package:tracker/util/db_helper.dart';

class AddCategory extends StatefulWidget {
  final int type;

  AddCategory(this.type);

  State<StatefulWidget> createState() => AddCategoryState(type);
}

class AddCategoryState extends State<AddCategory> {
  int type;
  final icons = [0xe57a, 0xeb44, 0xe850, 0xe88a];
  int selectedIcon;
  TextEditingController nameCtrl = new TextEditingController();
  DbHelper dbHelper = DbHelper();

  AddCategoryState(this.type);

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: _body(),
    );
  }

  Widget _body() {
    return Card(
        child: Control(ListView(children: [
      Control(DropdownButton(
          hint: Text('Choose an icon'),
          items: _getIcons(),
          value: selectedIcon,
          onChanged: onIconChange)),
      Control(InputBox(
        hint: "Ex: Food",
        label: "Category",
        ctrl: nameCtrl,
      )),
      Control(RaisedButton(child: Text("SAVE"), onPressed: save))
    ])));
  }

  void onIconChange(int value) {
    print('selected');
    print(value);
    setState(() => this.selectedIcon = value);
  }

  List<Widget> _getIcons() {
    return icons
        .map((int icon) => DropdownMenuItem(
            value: icon,
            child: Icon(IconData(icon, fontFamily: "MaterialIcons"))))
        .toList();
  }

  void save() async {
    if (nameCtrl.text.trim() == null || nameCtrl.text.trim() == "")
      return;
    else {
      Category category = Category(nameCtrl.text.trim(), selectedIcon, type);
      await dbHelper.init();
      dbHelper.insertCategory(category);
      Navigator.pop(context, true);
    }
  }
}
