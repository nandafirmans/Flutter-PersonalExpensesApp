import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AdaptiveFlatButton(this.text, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textChild = Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );

    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: textChild,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: onPressed,
            child: textChild,
          );
  }
}
