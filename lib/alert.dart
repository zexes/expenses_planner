import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyAlert {
  final BuildContext context;
  final Function onPressed;

  MyAlert({this.context, this.onPressed});

  void executeAlert() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Confirm Deletion",
      desc: "Do you want to Delete Transaction",
      buttons: [
        DialogButton(
          color: Colors.red,
          child: Text("Yes"),
          onPressed: onPressed,
        ),
        DialogButton(
          color: Colors.green,
          child: Text("No"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ).show();
  }
}
