import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '/components/chart.dart';
import '/components/transaction_form.dart';
import '/components/transaction_list.dart';
import '/models/transaction.dart';

void main() => initializeDateFormatting('pt_BR', null)
    .then((_) => runApp(const ExpensesApp()));

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData myTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: const Color.fromRGBO(11, 120, 216, 1),
        secondary: Colors.amber,
      ),
      appBarTheme: const AppBarTheme(
        color: Color.fromRGBO(13, 55, 162, 1),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        labelMedium: TextStyle(
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(11, 120, 216, 1),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
    );

    return MaterialApp(
      home: const MyHomePage(),
      theme: myTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: '3',
      title: 'Cartão',
      value: 15100.76,
      date: DateTime.now(),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final int id = _transactions.isNotEmpty
        ? int.parse(_transactions[_transactions.length - 1].id) + 1
        : 1;

    final newTransaction = Transaction(
      id: id.toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() => _transactions.add(newTransaction));

    Navigator.of(context).pop();
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              child: Chart(_recentTransactions),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
