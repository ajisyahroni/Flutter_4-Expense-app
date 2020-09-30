import 'package:flutter/material.dart';

class TopUpSaldo extends StatefulWidget {
  final Function topUpSaldoFn;

  TopUpSaldo({this.topUpSaldoFn});

  @override
  _TopUpSaldoState createState() => _TopUpSaldoState();
}

class _TopUpSaldoState extends State<TopUpSaldo> {
  final saldoController = TextEditingController();

  bool _isError = false;
  String _errorMessage;
  // Pattern _onlyNumberPattern = r'^[0-9]*$';
  RegExp _onlyNumberRegex = new RegExp(r'^-?[0-9][0-9\.]+$');

  void _startTopUpSaldo() {
    if (saldoController.text.isEmpty) {
      setState(() {
        _errorMessage = "required";
        _isError = true;
      });
      return;
    }

    setState(() {});
    widget.topUpSaldoFn(double.parse(saldoController.text));
  }

  void _realtimeValidation(observeInput) {
    bool _checkSaldoRegex = _onlyNumberRegex.hasMatch(observeInput);

    if (!_checkSaldoRegex) {
      setState(() {
        _errorMessage = "input must be a number";
        _isError = true;
      });
      return;
    }
    setState(() {
      _errorMessage = "";
      _isError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
          elevation: 3,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: saldoController,
            decoration: InputDecoration(
                errorStyle: TextStyle(color: Theme.of(context).errorColor),
                errorText: _errorMessage,
                hintText: 'Top up saldo',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.green[200],
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 20)),
            onSubmitted: (_) => _startTopUpSaldo(),
            onChanged: (saldoEntered) {
              _realtimeValidation(saldoEntered);
            },
          )),
    );
  }
}
