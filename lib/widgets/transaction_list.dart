import '../constants/constants.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({this.transactions});

  @override
  Widget build(BuildContext context) {
    //    NumberFormat f = NumberFormat.currency(locale: "en_US", symbol: "€");
    NumberFormat f = NumberFormat.currency(locale: "en_US", symbol: "\$");

    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '${f.currencySymbol}${transactions[index].amount.toStringAsFixed(2)}',
                          style: kTextStyler.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${transactions[index].title}',
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                              '${DateFormat.yMMMEd().format(transactions[index].date)}', // you can use pattern too
                              style: kTextStyler.copyWith(
                                  color: Colors.grey, fontSize: 15)),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
