import 'package:flutter/material.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Despesas Pessoais'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent[400],
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('Versão Inicial!!!'),
        ));
  }
}
