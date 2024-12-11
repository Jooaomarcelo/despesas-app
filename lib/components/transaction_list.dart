import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions
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
    );
  }
}
