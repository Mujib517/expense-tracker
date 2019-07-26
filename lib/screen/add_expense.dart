import 'package:flutter/material.dart';
import 'package:tracker/common/input_box.dart';
import 'package:tracker/common/input_type.dart';

class AddExpense extends StatefulWidget {
  State<StatefulWidget> createState() => AddExpenseState();
}

class AddExpenseState extends State<AddExpense> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add New Item',
              style: TextStyle(fontWeight: FontWeight.w300))),
      body: _prepareForm(),
    );
  }

  Widget _prepareForm() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: ListView(children: _prepareFormFields()));
  }

  List<Widget> _prepareFormFields() {
    List<Widget> widgets = new List<Widget>();
    widgets.add(_prepareCategory());
    widgets.add(_prepareDate());
    widgets.add(_prepareName());
    widgets.add(_prepareAmount());
    widgets.add(_prepareSaveButton());

    return widgets;
  }

  Widget _prepareAmount() {
    return ListTile(
        leading: const Icon(Icons.monetization_on),
        title: InputBox(
            hint: "Ex:Breakfast", label: "Amount", type: InputType.numeric));
  }

  Widget _prepareName() {
    return ListTile(
        leading: Icon(Icons.title),
        title: InputBox(hint: "ex:Breakfast", label: "Name"));
  }

  Widget _prepareDate() {
    return ListTile(
        leading: Icon(Icons.calendar_today),
        title: InputBox(hint: "Date", label: "Date", enabled: false));
  }

  Widget _prepareCategory() {
    return ListTile(
        leading: Icon(Icons.category),
        title: InputBox(hint: "Category", label: "Category"));
  }

  Widget _prepareSaveButton() {
    return ListTile(
        leading: Icon(Icons.save),
        title: RaisedButton(
            elevation: 14,
            color: Color.fromRGBO(58, 66, 86, 1.0),
            onPressed: () {},
            child: Text("SAVE")));
  }
}
