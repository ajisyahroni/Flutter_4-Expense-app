import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTxHandler;

  NewTransaction({this.addNewTxHandler});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final ammountController = TextEditingController();
  DateTime _selectedDate;

  void submitedTx() {
    if (ammountController.text.isEmpty) return;
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(ammountController.text);
    final enteredDate = _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      return;
    }
    widget.addNewTxHandler(enteredTitle, enteredAmount, enteredDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitedTx(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: ammountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitedTx(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date choosen'
                        : 'Picked date: ${DateFormat.MMMMd().format(_selectedDate)}',
                    style: TextStyle(
                        color:
                            _selectedDate == null ? Colors.grey : Colors.black),
                  ),
                ),
                FlatButton(
                  highlightColor: Colors.purple,
                  splashColor: Colors.purple[100],
                  child: Text(
                    'Choose date',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.purple[300]),
                  ),
                  onPressed: () => _showDatePicker(),
                ),
              ],
            ),
            FlatButton(
              color: Colors.purple[50],
              textColor: Colors.purple,
              child: Text('Add'),
              onPressed: () {
                submitedTx();
              },
            )
          ],
        ),
      ),
    );
  }
}
