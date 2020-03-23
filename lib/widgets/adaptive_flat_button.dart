import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const AdaptiveFlatButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: onPressed,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: const Text(
              'Choose Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: onPressed,
          );
  }
}
