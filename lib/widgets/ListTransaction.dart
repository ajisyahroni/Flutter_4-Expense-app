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
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 30,
                      color: Color(0xFFB7B7B7).withOpacity(.16))
                ]),
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
