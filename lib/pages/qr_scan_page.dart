import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_app/mysql.dart';
import 'package:mobile_app/widgets/button_widget.dart';
import 'package:mysql1/mysql1.dart';

import '../main.dart';

class QRScanPage extends StatelessWidget {
  final String result;
  const QRScanPage({Key? key, required this.result}) : super(key: key);

  //var db = new MySQL();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF404ccf),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    )
  );

  /*@override
  _QRScanPageState createState() => _QRScanPageState();*/
}

/*class _QRScanPageState extends State<QRScanPage> {
  var db = new MySQL();
  var description = '';

  void _getObject() {
    db.getConnection().then((conn) {
      String sql = 'select description from object where id_object = 44;';
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            description = row[0];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFF404ccf),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              //result,
              description,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            *//*ButtonWidget(
              text: 'Objects',
              onClicked: () => connectDatabase(),
          )*//*
          ],
        ),
      )
  );
}*/
