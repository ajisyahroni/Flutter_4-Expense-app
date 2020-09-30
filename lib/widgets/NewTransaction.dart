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
  DateTime _selectedDate = DateTime.now();

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
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'New Transaction',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              ),
              controller: titleController,
              onSubmitted: (_) => submitedTx(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Amount',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              ),
              controller: ammountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitedTx(),
            ),
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
                splashColor: Colors.purple,
                child: Text(
                  'Choose date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.purple[300]),
                ),
                onPressed: () => _showDatePicker(),
              ),
            ],
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.purple,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              'Add',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            onPressed: () {
              submitedTx();
            },
          )
        ],
      ),
    );
  }
}
