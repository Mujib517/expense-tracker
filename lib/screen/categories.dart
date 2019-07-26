import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  State<StatefulWidget> createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.attach_money), text: "Expense"),
                  Tab(icon: Icon(Icons.account_balance_wallet), text: "Income")
                ]),
                title: Text('Categories')),
            body: TabBarView(children: [
              Icon(Icons.attach_money),
              Icon(Icons.account_balance_wallet)
            ])));
  }
}
