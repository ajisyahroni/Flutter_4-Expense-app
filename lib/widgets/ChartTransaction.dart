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
      margin: EdgeInsets.all(15.0),
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
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((otd) {
            // OTD = Object To Data
            double calculateSpendingTotal =
                (otd['amount'] as double) / totalSpending;
            double percentOfSpendingTotal = calculateSpendingTotal.isNaN
                ? 0.0
                : calculateSpendingTotal >= 1.0
                    ? 1
                    : calculateSpendingTotal <= 0.0
                        ? 0.0
                        : calculateSpendingTotal;

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
    );
  }
}
