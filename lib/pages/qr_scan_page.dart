import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app/mysql.dart';

import 'error_page.dart';

class QRScanPage extends StatefulWidget {
  final String result;
  const QRScanPage({Key? key, required this.result}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  var db = MySQL();
  var id = '';
  var description = '';
  var room = '';
  var price = '';
  var date = '';

  void _getObject() {
    db.getConnection().then((conn) {
      String sql = 'select * from object where id_object = ${widget.result};';
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            date = row[0].toString();
            date = date.substring(0, 10);
            description = row[1].toString();
            price = row[2].toString();
            id = row[3].toString();
            room = row[4].toString();
            sql = 'select location_of_room from room where id_room = $room';
            conn.query(sql).then((results) {
              for (var row in results) {
                setState(() {
                  room = row[0].toString();
                });
              }
            });
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getObject();
    if (id == '') {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ErrorPage()));
    }
  }


  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFF404ccf),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Object #$id',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Room: $room',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      )
  );
}
