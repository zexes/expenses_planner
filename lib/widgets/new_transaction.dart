import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction({this.addTx});

  void submitData() {
    addTx(titleController.text, double.parse(amountController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
//              keyboardType: TextInputType.number,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true), //IOS
              onSubmitted: (_) => submitData,
            ),
            FlatButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
              onPressed: () => submitData,
            )
          ],
        ),
      ),
    );
  }
}
