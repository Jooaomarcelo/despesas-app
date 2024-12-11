import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/Transaction.dart';

void main() => initializeDateFormatting('pt_BR', null)
    .then((_) => runApp(const ExpensesApp()));

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final titleController = TextEditingController();
  final valueController = TextEditingController();

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
          Column(
            children: _transactions
                .map((tr) => Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(11, 120, 216, 1),
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'R\$${tr.value.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color.fromRGBO(11, 120, 216, 1),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                tr.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat('d MMM y', 'pt_BR').format(tr.date),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),
                  TextField(
                    controller: valueController,
                    decoration: InputDecoration(labelText: 'Valor (R\$)'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(11, 120, 216, 1),
                    ),
                    onPressed: () {
                      print(titleController.text);
                      print(valueController.text);
                    },
                    child: const Text('Nova Transação'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
