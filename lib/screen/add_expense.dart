import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker/common/input_box.dart';
import 'package:tracker/common/input_type.dart';
import 'package:tracker/common/message_box.dart';
import 'package:tracker/model/category.dart';
import 'package:tracker/model/entry.dart';
import 'package:tracker/model/type.dart';
import 'package:tracker/util/db_helper.dart';

class AddExpense extends StatefulWidget {
  State<StatefulWidget> createState() => AddExpenseState();
}

class AddExpenseState extends State<AddExpense> {
  Iterable<Category> categories = List<Category>();
  DbHelper dbHelper = DbHelper();
  int selectedCategory;
  DateTime selectedDate = DateTime.now();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController amtCtrl = new TextEditingController();

  void initState() {
    super.initState();
    getCategories();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Add New Item',
                style: TextStyle(fontWeight: FontWeight.w300))),
        body: _prepareForm());
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
            ctrl: amtCtrl,
            hint: "Ex:100",
            label: "Amount",
            type: InputType.numeric));
  }

  Widget _prepareName() {
    return ListTile(
        leading: Icon(Icons.title),
        title: InputBox(ctrl: nameCtrl, hint: "ex:Breakfast", label: "Name"));
  }

  Widget _prepareDate() {
    return ListTile(
        leading: Icon(Icons.calendar_today),
        title: RaisedButton(
          onPressed: showCalendar,
          child: Text(formatDate(selectedDate)),
        ));
  }

  Widget _prepareCategory() {
    return ListTile(
        leading: Icon(Icons.category),
        title: DropdownButton(
            value: selectedCategory,
            hint: Text("Category"),
            onChanged: (id) {
              setState(() {
                selectedCategory = id;
              });
            },
            items: catItems()));
  }

  List<Widget> catItems() {
    return categories.map((Category cat) => dropdownMenuItem(cat)).toList();
  }

  DropdownMenuItem<int> dropdownMenuItem(Category cat) {
    return DropdownMenuItem(
        value: cat.id,
        child: Row(children: [
          Icon(IconData(cat.icon, fontFamily: "MaterialIcons")),
          Text(" - "),
          Text(cat.name)
        ]));
  }

  Widget _prepareSaveButton() {
    return ListTile(
        leading: Icon(Icons.save),
        title: RaisedButton(
            elevation: 14,
            color: Color.fromRGBO(58, 66, 86, 1.0),
            onPressed: onSave,
            child: Text("SAVE")));
  }

  void getCategories() async {
    dbHelper.init();
    List<dynamic> data = await dbHelper.getCategoriesByType(EntryType.expense);
    List<Category> catData = List<Category>();
    for (var i = 0; i < data.length; i++) {
      catData.add(Category.fromObject(data[i]));
    }
    setState(() {
      categories = catData;
    });
  }

  showCalendar() async {
    var dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (dt != null)
      setState(() {
        selectedDate = dt;
      });
  }

  formatDate(DateTime dt) {
    return DateFormat.yMMMEd().format(dt);
  }

  toDateString(DateTime dt) {
    return DateFormat.yMd().format(dt).toString();
  }

  void onSave() async {
    int amount = num.tryParse(amtCtrl.text.trim()) ?? 0;
    Entry entry = Entry(selectedCategory, nameCtrl.text.trim(),
        toDateString(selectedDate), amount, EntryType.expense);
    if (!isFormValid(entry))
      showDialog(
          context: context,
          builder: (context) => MessageBox(
              title: "Validation Error", content: "Please fill all the data"));
    else {
      await dbHelper.insertEntry(entry);
      Navigator.pop(context);
    }
  }

  bool isFormValid(Entry entry) {
    return entry.categoryId != null && entry.name != null && entry.amount > 0;
  }
}
