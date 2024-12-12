import 'transaction_form.dart';
import 'transaction_list.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(_transactions),
        TransactionForm(_addTransaction),
      ],
    );
  }
}
