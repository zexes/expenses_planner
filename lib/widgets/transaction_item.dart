import '../model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final NumberFormat f;
  final Transaction transaction;
  final Function deleteTxn;
  final Function deleteTxn2;

  const TransactionItem({
    Key key,
    @required this.f,
    @required this.transaction,
    @required this.deleteTxn,
    @required this.deleteTxn2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                  '${f.currencySymbol}${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat.yMMMEd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () => deleteTxn(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTxn(transaction.id),
              ),
        onLongPress: () => deleteTxn2,
      ),
    );
  }
}
