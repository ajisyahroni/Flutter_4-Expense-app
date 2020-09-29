import 'package:flutter/material.dart';

class TopUpSaldo extends StatelessWidget {
  final Function topUpSaldoFn;
  final saldoController = TextEditingController();
  TopUpSaldo({this.topUpSaldoFn});
  void _startTopUpSaldo() {
    if (saldoController.text.isEmpty) return;
    topUpSaldoFn(double.parse(saldoController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          controller: saldoController,
          decoration: InputDecoration(hintText: 'Top up'),
          onSubmitted: (_) => _startTopUpSaldo(),
        ));
  }
}
