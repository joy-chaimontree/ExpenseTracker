import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd MMMM yyyy', 'th');

/*to generate unique ID*/
const uuid = Uuid();

/*enum is a special data type that represents
a set of predefined, named values*/
enum Category { food, travel, leisure, work}

const Map<Category, String> categoryNames = {
  Category.work : 'การทำงาน',
  Category.food : 'อาหารการกิน',
  Category.travel : 'การเดินทาง',
  Category.leisure : 'งานอดิเรก',
};

const categoryIcons = {
  Category.work : Icons.work_outline,
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.directions_bus_filled,
  Category.leisure : Icons.movie_creation_outlined,
};

class ExpenseData {
  ExpenseData({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  /*initializer list can be used to initialize class properties (like id)
  with values that are NOT receives as constructor function arguments*/

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
}
