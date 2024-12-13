import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final void Function({Transaction? tr}) onSubmit;
  final Transaction? tr;

  const TransactionForm({
    this.tr,
    required this.onSubmit,
    super.key,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.tr != null) {
      _titleController.text = widget.tr!.title;
      _valueController.text = widget.tr!.value.toString();
      _selectedDate = widget.tr!.date;
    }
  }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    final newTr = Transaction(
      id: '',
      title: title,
      value: value,
      date: _selectedDate,
    );

    if (widget.tr != null) {
      newTr.id = widget.tr!.id;
      widget.onSubmit(tr: newTr);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transação atualizada com sucesso!'),
        ),
      );

      return;
    }

    widget.onSubmit(tr: newTr);
    return;
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (_) => _submitForm(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Selecione uma data',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Salvar Transação'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
