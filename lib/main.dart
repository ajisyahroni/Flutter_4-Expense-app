import 'package:ExpenseApp/models/Transaction.dart';
import 'package:ExpenseApp/widgets/ListTransaction.dart';
import 'package:ExpenseApp/widgets/NewTransaction.dart';
import 'package:ExpenseApp/widgets/NotFoundTransaction.dart';
import 'package:ExpenseApp/widgets/TopUpSaldo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/ChartTransaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amberAccent,
          splashColor: Colors.green),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final scaffoldState = GlobalKey<ScaffoldState>();

class _MyHomePageState extends State<MyHomePage> {
  double saldo = 70;
  bool showWalletInput = false;

  final List<Transaction> _userTransactions = [
    Transaction(ammount: 10, title: 'buy a tea', date: DateTime.now()),
    Transaction(ammount: 30, title: 'buy a keyboard', date: DateTime.now())
  ];
  // list getter _recent transaction
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmmount, DateTime txDate) {
    final newTx = Transaction(ammount: txAmmount, title: txTitle, date: txDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
      Navigator.of(context).pop();
    });
  }

  Future<void> _startDeleteTransaction(Transaction tx) async {
    return showDialog<void>(
        context: context,
        child: AlertDialog(
          title: Text('Delete expense'),
          content: ListTile(
            title: Text(
              tx.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            subtitle: Text(
              DateFormat.yMMMd().add_jm().format(tx.date),
              style: TextStyle(color: Colors.grey),
            ),
            leading: CircleAvatar(
              radius: 30,
              child: Text('${tx.ammount.toStringAsFixed(0)}K'),
              backgroundColor: Colors.purple,
            ),
          ),
          actions: [
            FlatButton(
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () => _deleteTransaction(tx.id),
            )
          ],
        ));
  }

  void _startNewTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (_) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: NewTransaction(
                addNewTxHandler: _addNewTransaction,
              ));
        });
  }

  void topUpSaldo(double payloadSaldo) {
    setState(() {
      this.saldo += payloadSaldo;
      this.toggleWalletInput();
    });
  }

  void toggleWalletInput() {
    setState(() {
      this.showWalletInput = !this.showWalletInput;
    });
  }

  // void _startInputWallet(BuildContext ctx) {
  //   scaffoldState.currentState.showBottomSheet((context) {
  //     return NewTransaction(
  //       addNewTxHandler: _addNewTransaction,
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Expenses Planner'),
        actions: [
          Row(
            children: [
              Text('$saldo K'),
              IconButton(
                  icon: Icon(Icons.add), onPressed: () => toggleWalletInput())
            ],
          )
        ],
      ),
      body: Builder(builder: (context) {
        return _userTransactions.isEmpty
            ? NotFoundTransaction()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (showWalletInput)
                      TopUpSaldo(
                        topUpSaldoFn: topUpSaldo,
                      ),
                    ChartTransaction(
                      recentTransaction: _recentTransaction,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    ListTransaction(
                      transactions: _userTransactions,
                      deleteTx: _startDeleteTransaction,
                    )
                  ],
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransactionModal(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
