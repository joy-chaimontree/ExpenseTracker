import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense_data.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseData> _registeredExpenses = [
    ExpenseData(
      title: 'ซื้อคอร์สออนไลน์',
      amount: 9.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseData(
      title: 'ดูหนัง',
      amount: 5.19,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    /*dialog popup from bottom after pressed*/
    showModalBottomSheet(
      /*widget will cover entire screen*/
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  /* add new item to the list from new_expense page (onAddExpense)*/
  void _addExpense(ExpenseData expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  /*swipe to remove expense list*/
  void _removeExpense(ExpenseData expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    /*remove the old message Snackbars immediately*/
    ScaffoldMessenger.of(context).clearSnackBars();
    /*show message when user removing the expense list*/
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('ทำการลบรายการแล้ว'),
        /*bring back expense list that user accidentally delete*/
        action: SnackBarAction(
          label: 'ยกเลิก',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*show message whenever list is empty*/
    Widget mainContent = const Center(
      child: Text('ไม่มีข้อมูล โปรดเพิ่มรายการใหม่'),
    );
    if (_registeredExpenses.isNotEmpty) {
      /*hard code expense list*/
      mainContent = ExpensesList(
        expenseData: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker App'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('ตารางค่าใช้จ่าย'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
