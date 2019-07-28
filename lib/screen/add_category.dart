import 'package:flutter/material.dart';
import 'package:tracker/model/type.dart';

class AddCategory extends StatefulWidget {
  final EntryType type;

  AddCategory(this.type);

  State<StatefulWidget> createState() => AddCategoryState(type);
}

class AddCategoryState extends State<AddCategory> {
  EntryType type;

  AddCategoryState(this.type);

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Add Category")));
  }
}
