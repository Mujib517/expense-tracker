import 'package:flutter/material.dart';
import 'package:tracker/model/type.dart';

class AddCategory extends StatefulWidget {
  final EntryType type;

  AddCategory(this.type);

  State<StatefulWidget> createState() => AddCategoryState(type);
}

class AddCategoryState extends State<AddCategory> {
  EntryType type;
  int selected = 0;
  final icons = [0xe57a, 0xeb44, 0xe850, 0xe88a];

  AddCategoryState(this.type);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: _body(),
    );
  }

  Widget _body() {
    return ListView(children: _getIcons());
  }

  List<Widget> _getIcons() {
    return icons
        .map((int icon) => ListTile(
              leading: Icon(IconData(icon, fontFamily: "MaterialIcons")),
              title: Radio(
                  value: icon,
                  groupValue: selected,
                  onChanged: (int index) {
                    setState() {
                      this.selected = icons[index];
                    }
                  }),
            ))
        .toList();
  }
}
