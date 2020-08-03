import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_transactions.dart';
import 'package:personal_expenses_app/widgets/new_transaction_form.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _transactions = [];
  bool _isShowChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((t) => t.date.isAfter(
              DateTime.now().subtract(
                Duration(days: 7),
              ),
            ))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: date.toString(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) => t.id == id);
    });
  }

  void _showNewTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => GestureDetector(
        onTap: () {},
        child: NewTransactionForm(
          addNewTransaction: _addNewTransaction,
        ),
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showNewTransactionForm(context),
        )
      ],
    );

    final mainWidgetHeight = (mediaQuery.size.height -
        mediaQuery.padding.top -
        appBar.preferredSize.height);

    final chartTransactions = Container(
      height: mainWidgetHeight * (isLandscape ? 0.7 : 0.3),
      child: ChartTransactions(
        transaction: _recentTransactions,
      ),
    );

    final transactionList = Container(
      height: mainWidgetHeight * (isLandscape ? 0.8 : 0.7),
      child: TransactionList(
        transactions: _transactions,
        removeTransaction: _removeTransaction,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                    value: _isShowChart,
                    onChanged: (val) => setState(() => _isShowChart = val),
                  )
                ],
              ),
            if (isLandscape)
              if (_isShowChart) chartTransactions else transactionList,
            if (!isLandscape) chartTransactions,
            if (!isLandscape) transactionList
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showNewTransactionForm(context),
      ),
    );
  }
}
