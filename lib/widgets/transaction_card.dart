import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionCard extends StatefulWidget {
  // const is a variables/properties that value can never change even at the compile times.
  static const String test = "";

  // final is a variables/properties that created dynamically at runtime but it's value never is changes. its value immutable..
  final Transaction transaction;
  final Function removeTransaction;

  // const constructor can be done if every fields on a class is using final/const variable.
  // basically all stateless widget are immutable so this const constructor is not necessary.
  const TransactionCard({
    Key key,
    this.transaction,
    this.removeTransaction,
  }) : super(key: key);

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  Color _backgroundColor;
  static const List<Color> _availableColors = [
    Colors.red,
    Colors.black,
    Colors.blue,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();

    final randomColorIndex = Random().nextInt(_availableColors.length);
    _backgroundColor = _availableColors[randomColorIndex];
  }

  void _removeTransaction() {
    widget.removeTransaction(widget.transaction.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              NumberFormat.compact().format(widget.transaction.amount),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
              ),
            ),
          ),
        ),
        title: Text(
          "${widget.transaction.title} - IDR ${NumberFormat("#,###").format(widget.transaction.amount)}",
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                // creating an object with constant expression can skip an unnecessary widgets rebuild.
                // in this case Icon & Text object arguments is never change, so it's object can be created with constant expression.
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: _removeTransaction,
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: _removeTransaction),
      ),
    );
  }
}
