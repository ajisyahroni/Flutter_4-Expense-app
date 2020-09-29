import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingOfTotalinPercent;
  ChartBar({this.label, this.spendingAmount, this.spendingOfTotalinPercent});

  @override
  Widget build(BuildContext context) {
    final today = DateFormat.E().format(DateTime.now()).substring(0, 3);
    bool checkToday = label == today;
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text('${spendingAmount.toStringAsFixed(0)}K'))),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spendingOfTotalinPercent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: TextStyle(
              color: checkToday ? Colors.amber : Colors.grey,
              fontWeight: checkToday ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
