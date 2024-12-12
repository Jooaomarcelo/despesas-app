import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '/components/transaction_form.dart';
import '/components/transaction_list.dart';
import '/models/transaction.dart';

void main() => initializeDateFormatting('pt_BR', null)
    .then((_) => runApp(const ExpensesApp()));

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
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
        date: DateTime.now().subtract(const Duration(days: 1))),
  ];

  void _addTransaction(String title, double value) {
    final int id = _transactions.isNotEmpty
        ? int.parse(_transactions[_transactions.length - 1].id) + 1
        : 1;

    final newTransaction = Transaction(
      id: id.toString(),
      title: title,
      value: value,
      date: DateTime.now().subtract(const Duration(days: 1)),
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
        backgroundColor: Colors.blueAccent[400],
        foregroundColor: Colors.white,
        actions: [
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
              child: Card(
                color: Colors.blueAccent[400],
                elevation: 5,
                child: const Text('Gráfico'),
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Colors.blueAccent[400],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
