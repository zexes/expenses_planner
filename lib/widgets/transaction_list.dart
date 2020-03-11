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

    return ListView(
      children: transactions
          .map((tx) => Card(
                  child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '${f.currencySymbol}${tx.amount}',
                      style: kTextStyler,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${tx.title}',
                        style: kTextStyler.copyWith(
                            fontSize: 16.0, color: Colors.black),
                      ),
                      Text(
                          '${DateFormat.yMMMEd().format(tx.date)}', // you can use pattern too
                          style: kTextStyler.copyWith(
                              color: Colors.grey, fontSize: 15)),
                    ],
                  )
                ],
              )))
          .toList(),
    );
  }
}
