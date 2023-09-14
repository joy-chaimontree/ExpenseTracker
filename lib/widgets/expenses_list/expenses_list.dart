import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_data.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenseData,
    required this.onRemoveExpense,
  });

  final List<ExpenseData> expenseData;
  final void Function(ExpenseData expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    /*ListView.builder is a more efficient way to create lists,
    especially for large or dynamic lists*/
    return ListView.builder(
      itemCount: expenseData.length,
      /*Dismissible Creates a widget that can be removed*/
      itemBuilder: (ctx, index) => Dismissible(
        /*key is needed to allow flutter to uniquely identify a widget*/
        key: ValueKey(expenseData[index]),
        onDismissed: (direction) {
          onRemoveExpense(expenseData[index]);
        },
        child: ExpenseItem(
            expenseData[index]), /*use index to access a single expense*/
      ),
    );
  }
}
