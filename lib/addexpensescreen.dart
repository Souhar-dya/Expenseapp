import 'package:expense/datamodel/Expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key, required this.onPress}) : super(key: key);
  final void Function(Expenses expense) onPress;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _shopController = TextEditingController();
  DateTime? pickedDate;
  Category? selectedCategory = Category.miscellaneous;
  final formatter = DateFormat('MMM dd, yyyy');

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _shopController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    var amount = double.tryParse(_amountController.text);
    final isAmountInvalid = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        isAmountInvalid ||
        pickedDate == null ||
        (selectedCategory == Category.food &&
            _shopController.text.trim().isEmpty)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please make sure valid values were entered."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    } else {
      widget.onPress(
        Expenses(
          title: _titleController.text,
          amount: amount,
          shop: _shopController.text,
          category: selectedCategory!,
          date: pickedDate!,
        ),
      );
    }
  }

  void _presentDatePicker() async {
    final today = DateTime.now();
    final upperlimit = DateTime(today.year, today.month, 1);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: upperlimit,
      lastDate: today,
    );

    if (selectedDate != null) {
      setState(() {
        pickedDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 30,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '₹',
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      pickedDate == null
                          ? "Date not Selected"
                          : formatter.format(pickedDate!).toString(),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() async {
                    selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              Expanded(
                child: TextField(
                  controller: _shopController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(label: Text("Shop")),
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              const Spacer(),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
