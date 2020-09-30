import 'package:flutter/material.dart';

class SaldoStats extends StatelessWidget {
  final double recentSaldo;
  final double outcome;
  final Function toggleWalletInputFn;
  SaldoStats({this.recentSaldo, this.outcome, this.toggleWalletInputFn});

  double get fractionIncomeOutcome {
    if (recentSaldo <= 0) return 0;
    return (recentSaldo / recentSaldo) - (outcome / recentSaldo);
  }

  double get percentageIncomeOutcome {
    if (recentSaldo == 0) return 0;
    return ((recentSaldo / recentSaldo) - (outcome / recentSaldo)) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF3383CD),
            Colors.deepPurpleAccent,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () => toggleWalletInputFn(),
                )
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 40,
                child: FlutterLogo(),
                backgroundColor: Colors.white10,
              ),
              title: Text(
                'Hi! Aji Syahroni',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 20),
              ),
              subtitle: fractionIncomeOutcome <= 0
                  ? Text(
                      '${recentSaldo.toStringAsFixed(0)}k - danger finance',
                      style: TextStyle(color: Colors.orangeAccent),
                    )
                  : Text(
                      '${recentSaldo.toStringAsFixed(0)}k',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Saldo: ${this.recentSaldo.toStringAsFixed(0)}k',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Pengeluaran: ${this.outcome.toStringAsFixed(0)}k',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Stack(
              children: [
                Container(
                  height: 20,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  widthFactor:
                      (fractionIncomeOutcome < 0) ? 0 : fractionIncomeOutcome,
                  child: Container(
                    child: Text(
                      '${percentageIncomeOutcome.toStringAsFixed(0)}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    height: 20,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
