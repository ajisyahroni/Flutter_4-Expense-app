import 'package:flutter/foundation.dart';

class Transaction {
  // doesnt change after, so i using final
  String id;
  final String title;
  final double ammount;
  DateTime date;

  Transaction({
    @required this.title,
    @required this.ammount,
    @required this.date,
  }) {
    this.id = DateTime.now().toString();
  }
}
