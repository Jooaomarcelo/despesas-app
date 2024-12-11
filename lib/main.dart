import 'package:flutter/material.dart';
import 'models/Transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _transactions = [
    Transaction(
      id: '1',
      title: 'Meu novo tênis de corrida',
      value: 329.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Despesas Pessoais'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent[400],
          foregroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              child: Card(
                color: Colors.blueAccent[400],
                elevation: 5,
                child: const Text('Gráfico'),
              ),
            ),
            const Card(
              child: Text('Lista de Transações'),
            )
          ],
        ));
  }
}
