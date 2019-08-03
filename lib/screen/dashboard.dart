import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:tracker/model/type.dart';
import 'package:tracker/util/db_helper.dart';

class Dashboard extends StatefulWidget {
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  List<Expense> expenseData = List<Expense>();
  DbHelper dbHelper = DbHelper();

  void initState() {
//    loadData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Dashboard")), body: _body);
  }

  void loadData() async {
    await dbHelper.init();
    List<dynamic> data = await dbHelper.groupByCategory(EntryType.expense);
    List<Expense> temp = List<Expense>();
    for (var i = 0; i < data.length; i++) {
      temp.add(Expense.fromObj(data[i]));
    }
    setState(() {
      expenseData = temp;
    });
  }

  List<charts.Series<Expense, int>> _createSampleData() {
    return [
      new charts.Series<Expense, int>(
          id: 'Sales',
          labelAccessorFn: (Expense exp, _) => exp.category,
          domainFn: (Expense exp, _) => exp.amount,
          measureFn: (Expense exp, _) => exp.amount,
          data: expenseData)
    ];
  }

  get _body => charts.PieChart(_createSampleData(),
      animate: true,
      defaultRenderer: new charts.ArcRendererConfig(arcWidth: 60));
}

class Expense {
  String category;
  num amount;

  Expense(this.category, this.amount);

  Expense.fromObj(dynamic obj) {
    category = obj["category"];
    amount = obj["amount"];
  }
}
