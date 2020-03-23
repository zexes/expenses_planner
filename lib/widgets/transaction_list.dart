import 'package:intl/intl.dart';

import '../model/transaction.dart';
import 'package:flutter/material.dart';

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
              return Card(
                elevation: 5.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                            '${f.currencySymbol}${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteTxn(transactions[index].id),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTxn(transactions[index].id),
                        ),
                  onLongPress: () => deleteTxn2(index),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
