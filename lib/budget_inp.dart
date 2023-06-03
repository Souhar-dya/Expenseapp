import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_screen.dart';

class InputBudgetPage extends StatefulWidget {
  const InputBudgetPage({super.key});

  @override
  State<InputBudgetPage> createState() => _InputBudgetPageState();
}

class _InputBudgetPageState extends State<InputBudgetPage> {
  final _budgetController = TextEditingController();

  void onCancel() {
    SystemNavigator.pop();
  }

  bool check() {
    if (double.tryParse(_budgetController.text) == null ||
        double.tryParse(_budgetController.text)! <= 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    void onEnter() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please make sure valid values were entered."),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Okay"))
          ],
        ),
      );
      return;
    }

    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(36, 52, 71, 1),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/applogo.png",
                width: 230,
                height: 180,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _budgetController,
                  decoration: InputDecoration(
                    hintText: 'Input Budget',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: onCancel,
                    icon: const Icon(Icons.logout_sharp),
                    label: const Text("Cancel"),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  ElevatedButton.icon(
                      onPressed: () => check()
                          ? onEnter()
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                        monthbudget:
                                            int.parse(_budgetController.text),
                                      ))),
                      icon: const Icon(Icons.login),
                      label: const Text("Enter"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
