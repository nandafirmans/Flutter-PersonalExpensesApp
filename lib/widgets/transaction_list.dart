import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionList({
    this.transactions,
    this.removeTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "No transactions added yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 100,
                  child: Image.asset(
                    "assets/image/waiting.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) => TransactionCard(
                transaction: transactions[index],
                removeTransaction: removeTransaction,
              ),
              itemCount: transactions.length,
            ),
    );
  }
}
