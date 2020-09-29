import 'package:ExpenseApp/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  ListTransaction({this.transactions, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.purple,
                child: Padding(
                    padding: EdgeInsets.all(3),
                    child: FittedBox(
                      child: Text(
                          '${transactions[index].ammount.toStringAsFixed(0)}K'),
                    )),
              ),
              title: Text(
                transactions[index].title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              subtitle: Text(
                DateFormat.yMMMd().add_jm().format(transactions[index].date),
                style: TextStyle(color: Colors.grey),
              ),
              trailing: IconButton(
                onPressed: () => deleteTx(transactions[index]),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
