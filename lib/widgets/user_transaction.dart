import '../model/transaction.dart';

import './transaction_list.dart';
import 'package:flutter/material.dart';

import './new_transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "t1", title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t2",
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        NewTransaction(addTx: _addNewTransaction),
        TransactionList(
          transactions: _userTransactions,
        ),
      ],
    );
  }
}
