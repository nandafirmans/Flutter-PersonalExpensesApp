import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  const TransactionList({
    this.transactions,
    this.removeTransaction,
  });

  Widget _buildChild(BuildContext context) => transactions.isEmpty
      ? LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FittedBox(
                child: Text(
                  "No transactions added yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.2,
              ),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset(
                  "assets/image/waiting.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        )
      : ListView(
          children: transactions
              .map((trx) => TransactionCard(
                    key: ValueKey(trx.id),
                    transaction: trx,
                    removeTransaction: removeTransaction,
                  ))
              .toList(),
        );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: _buildChild(context),
    );
  }
}
