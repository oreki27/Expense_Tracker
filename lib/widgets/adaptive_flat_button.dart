import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final VoidCallback handler;
  final String text;

  AdaptiveFlatButton(
      this.text,
      this.handler
      );
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
      onPressed: () => handler,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
    )
        : FlatButton(
      onPressed: () => handler,
      textColor: Theme.of(context).primaryColor,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
