import 'package:expense/budget_inp.dart';
import 'package:expense/startscreen.dart';
import 'package:flutter/material.dart';
import 'utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartScreen(),
      routes: {
        MyRoutes.startPage: (context) => const StartScreen(),
        MyRoutes.homePage: (context) => const InputBudgetPage(),
      },
    );
  }
}
