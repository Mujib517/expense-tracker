import 'package:flutter/material.dart';
import 'package:tracker/screen/add_expense.dart';
import 'package:tracker/screen/expense_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Oxygen',
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: ExpenseList(),
    );
  }
}
