import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({super.key});

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
