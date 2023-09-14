import 'package:flutter/material.dart';
import '../../models/expense_data.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenseInfo, {super.key});

  final ExpenseData expenseInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expenseInfo.title),
            const SizedBox(height: 4),
            /*Price*/
            Row(
              children: [
                Text('฿ ${expenseInfo.amount.toStringAsFixed(2)}'),
                //to set number display 12.1212 => 12.12 (2 decimals)
                const Spacer(),
                /*Show category Icon*/
                Icon(categoryIcons[expenseInfo.category]),
                /*Show date: day/m/year*/
                Text(expenseInfo.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
