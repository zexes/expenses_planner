import 'package:intl/intl.dart';

import '../model/transaction.dart';
import 'package:flutter/material.dart';

import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTxn;
  final Function deleteTxn2;

  TransactionList({this.transactions, this.deleteTxn, this.deleteTxn2});

  @override
  Widget build(BuildContext context) {
    //    NumberFormat f = NumberFormat.currency(locale: "en_US", symbol: "€");
    NumberFormat f = NumberFormat.currency(locale: "en_US", symbol: "\$");

    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.2,
                  child: Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                f: f,
                transaction: transactions[index],
                deleteTxn: deleteTxn,
                deleteTxn2: deleteTxn2,
                index: index,
              );
            },
            itemCount: transactions.length,
          );
  }
}
