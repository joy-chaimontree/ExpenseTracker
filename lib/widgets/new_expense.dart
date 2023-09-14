import 'package:expense_tracker/models/expense_data.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
  });

  final void Function(ExpenseData expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  /*handling user input*/
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _currentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('th', 'TH'),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _summitExpenseData() {
    /*convert text to a number (double) If not, it sets to null*/
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    /*.trim() removes any leading and trailing whitespace*/
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      /*If any of the conditions above are true, show error message error*/
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('ไม่สามารถบันทึกข้อมูลได้'),
          content: const Text('โปรดเช็คความถูกต้องและกรอกข้อมูลให้ครบทุกช่อง'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('ตกลง'),
            ),
          ],
        ),
      );
      /*used to exit the function early if any of the conditions are met*/
      return;
    }
    /*pass the value in ExpenseData to onAddExpense*/
    widget.onAddExpense(
      ExpenseData(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    /*close dialog after adding expense*/
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 50,
      ),
      /*type the subject topic*/
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('ชื่อเรื่อง'),
            ),
          ),
          /*type the price*/
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '฿ ',
                    label: Text('ราคา'),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              /*choosing the date*/
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'ยังไม่ได้เลือกวันที่'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: () => _currentDatePicker(),
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              /* call map to transform type */
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (categoryItem) => DropdownMenuItem(
                          value: categoryItem,
                          /* categoryNames[categoryItem] is an expression that looks up
                          the translation for the categoryItem in the categoryNames map */
                          child: Text(categoryNames[categoryItem] ?? ''),
                          /* ?? = null-aware operator returns expression on its left
                           (if null returns right expression) */
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  }),
              /*Creates a flexible space to insert into a Flexible widget*/
              const Spacer(),
              /*txt btn ยกเลิก*/
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ยกเลิก'),
              ),
              /*btn บันทึกข้อมูล*/
              ElevatedButton(
                onPressed: _summitExpenseData,
                child: const Text('บันทึกข้อมูล'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
