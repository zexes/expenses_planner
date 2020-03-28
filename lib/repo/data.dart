import '../model/transaction.dart';
import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  List<Transaction> userTransactions = [
    Transaction(
        id: "t1", title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: "t2",
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now())
  ];

  void addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    userTransactions.add(newTx);
    notifyListeners();
  }
}
