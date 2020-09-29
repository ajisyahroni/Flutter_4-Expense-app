import 'package:flutter/material.dart';

class NotFoundTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset('assets/images/page-not-found.png'),
      SizedBox(
        height: 20.0,
      ),
      Text(
        'Transaction Not Found',
        style: TextStyle(fontSize: 20.0),
      )
    ]));
  }
}
