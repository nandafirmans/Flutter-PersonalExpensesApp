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
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: _removeTransaction,
        ),
      ),
    );
  }
}
