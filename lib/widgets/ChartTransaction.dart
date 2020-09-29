import 'package:ExpenseApp/models/Transaction.dart';
import 'package:ExpenseApp/widgets/ChartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartTransaction extends StatelessWidget {
  final List<Transaction> recentTransaction;
  ChartTransaction({this.recentTransaction});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // date initial

      final weekDay = DateTime.now().subtract(Duration(days: index));
      String dateInitial = DateFormat.E().format(weekDay).substring(0, 3);

      // amount calculation
      double totalSum = 0.0;
      for (var tx in recentTransaction) {
        bool dayCondition = tx.date.day == weekDay.day;
        bool monthCondition = tx.date.month == weekDay.month;
        bool yearCondition = tx.date.year == weekDay.year;

        if (dayCondition && monthCondition && yearCondition) {
          totalSum += tx.ammount;
        }
      }
      // end calculation

      return {
        'day': dateInitial,
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return recentTransaction.fold(0.0, (previousValue, element) {
      return previousValue + element.ammount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((otd) {
              // OTD = Object To Data
              double percentOfSpendingTotal =
                  (otd['amount'] as double) / totalSpending;
              return Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ChartBar(
                  label: otd['day'],
                  spendingAmount: otd['amount'],
                  spendingOfTotalinPercent: percentOfSpendingTotal == 0.0
                      ? 0.0
                      : percentOfSpendingTotal,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
