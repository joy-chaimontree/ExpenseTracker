import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const Expenses(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate, // Add this line
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('th', 'TH'), // Add your supported locales here
          Locale('en', 'US'), // Add more locales if needed
        ],
      ),
    );

final formatter = DateFormat('dd MMMM yyyy', 'th');
