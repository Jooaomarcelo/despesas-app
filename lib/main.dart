import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/components/chart.dart';
import '/components/transaction_form.dart';
import '/components/transaction_list.dart';
import '/models/transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData myTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: const Color.fromRGBO(11, 120, 216, 1),
        onPrimary: Colors.white,
        secondary: Colors.amber,
        error: Colors.red[400],
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
      datePickerTheme: const DatePickerThemeData(
        headerBackgroundColor: Color.fromRGBO(11, 120, 216, 1),
        headerForegroundColor: Colors.white,
      ),
    );

    return MaterialApp(
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
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
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  _addTransaction({Transaction? tr}) {
    if (tr == null) {
      return;
    }

    final int newId = _transactions.isNotEmpty
        ? int.parse(_transactions[_transactions.length - 1].id) + 1
        : 1;

    tr.id = newId.toString();

    setState(() => _transactions.add(tr));

    Navigator.of(context).pop();
  }

  _editTransaction({Transaction? tr}) {
    if (tr == null) {
      return;
    }

    final editedTr =
        _transactions.firstWhere((transaction) => transaction.id == tr.id);

    setState(() {
      editedTr.title = tr.title;
      editedTr.value = tr.value;
      editedTr.date = tr.date;
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context, {Transaction? tr}) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(
          onSubmit: tr == null ? _addTransaction : _editTransaction,
          tr: tr,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;

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
              height: availableHeight * 0.3,
              child: Chart(_recentTransactions),
            ),
            SizedBox(
                height: availableHeight * 0.7,
                child: TransactionList(
                  transactions: _transactions,
                  onDelete: _removeTransaction,
                  openTransactionFormModal: _openTransactionFormModal,
                )),
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
