import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: "1",
      title: "New Shoes",
      amount: 300,
      date: DateTime.now(),
    ),
    Transaction(
      id: "2",
      title: "Indomie",
      amount: 15,
      date: DateTime.now(),
    )
  ];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Text("Chart here..."),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 0,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: "title"),
                      controller: titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "amount"),
                      controller: amountController,
                    ),
                    FlatButton(
                      child: Text("Add Transaction"),
                      textColor: Colors.purple,
                      onPressed: null,
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: transactions.map((transaction) {
                return Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            right: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.purple,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text(
                            "Rp ${transaction.amount}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 5,
                              ),
                              child: Text(
                                transaction.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(transaction.date),
                              style: TextStyle(
                                color: Colors.black.withAlpha(100),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ));
  }
}
