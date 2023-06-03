import 'package:expense/addexpensescreen.dart';
import 'package:expense/budget_part.dart';
import 'package:expense/chart.dart';
import 'package:expense/datamodel/Expenses.dart';
import 'package:expense/list_buider.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key, required this.monthbudget});
  int monthbudget;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Expenses> _registeredexpenses = [
    Expenses(
        title: "Chicken Roll",
        amount: 60,
        shop: "Enzo",
        category: Category.food,
        date: DateTime.now()),
    Expenses(
        title: "Biriyani",
        amount: 120,
        shop: "Tara Maa",
        category: Category.food,
        date: DateTime.now())
  ];
  void onIconAdd() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddExpense(
        onPress: onAdd,
      ),
    );
  }

  void onAdd(Expenses expense) {
    setState(() {
      _registeredexpenses.add(expense);
    });
    Navigator.pop(context);
  }

  void update(int expenseIndex, Expenses expense) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredexpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void onRemove(Expenses expense) {
    final expenseIndex = _registeredexpenses.indexOf(expense);
    setState(() {
      _registeredexpenses.remove(expense);
    });
    update(expenseIndex, expense);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent;
    mainContent = const Center(child: Text("No expenses yet.Add some now!"));
    if (_registeredexpenses.isNotEmpty) {
      mainContent = Column(
        children: [
          Expanded(
              child: ListOfExpenses(
            expenses: _registeredexpenses,
            onRemove: onRemove,
          ))
        ],
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: onIconAdd, child: const Icon(Icons.add)),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: Text(
                  "Balance: ₹${widget.monthbudget}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Chart(expenses: _registeredexpenses),
          Expanded(
            child: mainContent,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BudgetPage(
                  currentBudget: widget.monthbudget,
                  onBudgetChanged: (newBudget) {
                    setState(() {
                      widget.monthbudget = newBudget;
                    });
                  },
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Budget',
          ),
        ],
      ),
    );
  }
}
