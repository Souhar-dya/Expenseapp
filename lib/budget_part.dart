import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  final int currentBudget;
  final ValueChanged<int> onBudgetChanged;

  const BudgetPage({
    Key? key,
    required this.currentBudget,
    required this.onBudgetChanged,
  }) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late TextEditingController _budgetController;

  @override
  void initState() {
    super.initState();
    _budgetController =
        TextEditingController(text: widget.currentBudget.toString());
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  void onSave() {
    final newBudget = int.tryParse(_budgetController.text);
    if (newBudget != null) {
      widget.onBudgetChanged(newBudget);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _budgetController,
              decoration: const InputDecoration(
                labelText: 'Budget',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onSave,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
