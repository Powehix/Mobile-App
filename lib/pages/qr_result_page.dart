import 'package:flutter/material.dart';
import 'package:mobile_app/mysql.dart';
import 'package:mobile_app/pages/qr_scan_page.dart';
import 'package:mobile_app/widgets/button_widget.dart';

import '../main.dart';

class QRResultPage extends StatefulWidget {
  final String result;
  const QRResultPage({Key? key, required this.result}) : super(key: key);

  @override
  _QRResultPageState createState() => _QRResultPageState();
}

class _QRResultPageState extends State<QRResultPage> {
  var db = MySQL();
  var id = 'Unknown';
  var description = 'Unknown';
  var room = 'Unknown';
  var price = 'Unknown';
  var date = 'Unknown';

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
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFF404ccf),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/box_illustration.png',
              width: 150,
              height: 250,
            ),
            Text(
              'Object #$id',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Text(
              'Room: $room',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            const SizedBox(height: 78),
            ButtonWidget(
              text: 'Scan again',
              onClicked: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const QRScanPage()
              )),
              backgroundColor: Colors.white,
              textColor: const Color(0xFF404ccf),
              padding: const EdgeInsets.symmetric(horizontal: 84, vertical: 16),
            ),
            const SizedBox(height: 16),
            ButtonWidget(
              text: 'Return home',
              onClicked: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MainPage()
              )),
              backgroundColor: const Color(0xFF7480fd),
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 78, vertical: 16),
            ),
          ],
        ),
      )
  );
}
