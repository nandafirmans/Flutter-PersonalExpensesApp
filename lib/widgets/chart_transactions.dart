import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/chart.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class ChartTransactions extends StatelessWidget {
  final List<Transaction> transaction;

  ChartTransactions({
    this.transaction,
  });

  List<Chart> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final DateTime weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      final Iterable<Transaction> transactionsWeekDay = transaction.where((t) =>
          (t.date.day == weekDay.day &&
              t.date.month == weekDay.month &&
              t.date.year == weekDay.year &&
              t.amount > 0));
      final double totalSum = transactionsWeekDay.isEmpty
          ? 0
          : transactionsWeekDay.fold(
              0,
              (total, t) => total += t.amount,
            );

      return Chart(
        amount: totalSum,
        day: DateFormat.E().format(weekDay),
      );
    }).reversed.toList();
  }

  double get _totalSpending {
    return _groupedTransactionValues.fold(
      0,
      (total, gt) => total += gt.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionValues
              .map((t) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      amount: t.amount,
                      amountPercentage:
                          _totalSpending == 0 ? 0 : t.amount / _totalSpending,
                      label: t.day,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
