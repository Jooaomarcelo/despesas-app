import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onDelete;
  final Function(BuildContext, {Transaction tr}) openTransactionFormModal;

  const TransactionList({
    required this.transactions,
    required this.onDelete,
    required this.openTransactionFormModal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text(
                'Nenhuma transação cadastrada!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Dismissible(
                key: Key(tr.id),
                direction: DismissDirection.startToEnd,
                confirmDismiss: (direction) async {
                  await openTransactionFormModal(context, tr: tr);
                  return false;
                },
                background: Container(
                  color: Theme.of(context).colorScheme.primary,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text('R\$${tr.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(DateFormat.yMMMd(
                            Localizations.localeOf(context).toString())
                        .format(tr.date)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () => onDelete(tr.id),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
