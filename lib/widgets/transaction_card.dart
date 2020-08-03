import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function removeTransaction;

  TransactionCard({
    this.transaction,
    this.removeTransaction,
  });

  void _removeTransaction() {
    removeTransaction(transaction.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Text(
              NumberFormat.compact().format(transaction.amount),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        title: Text(
          "${transaction.title} - IDR ${NumberFormat("#,###").format(transaction.amount)}",
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: _removeTransaction,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: _removeTransaction,
              ),
      ),
    );
  }
}
