import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/pages/qr_scan_page.dart';

import '../mysql.dart';
import '../widgets/button_widget.dart';

class ProcessInventoryPage extends StatefulWidget {
  final String result;
  final int counter;
  const ProcessInventoryPage({Key? key, required this.result, required this.counter}) : super(key: key);

  @override
  _ProcessInventoryPageState createState() => _ProcessInventoryPageState();
}

class _ProcessInventoryPageState extends State<ProcessInventoryPage> {
  var db = MySQL();
  var numberOfObjects = 'Unknown';
  var locationOfRoom = 'Unknown';

  void _getRoom() {
    db.getConnection().then((conn) {
      String sql = 'select number_of_objects, location_of_room from room where id_room = ${widget.result};';
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            numberOfObjects = row[0].toString();
            locationOfRoom = row[1].toString();
          });
        }
      });
    });
  }

  void _stopInventory() {
    DateTime now = DateTime.now();
    DateTime date = DateTime.utc(now.year, now.month, now.day);

    db.getConnection().then((conn) async {
      var res = await conn.query('insert into inventory (date, result, id_room) values (?, ?, ?)',
          [date, 'Unsuccessful', widget.result]);
      print('Inserted row id_inventory=${res.insertId}');
      await conn.close();
    });

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const MainPage()
    ));
  }

  @override
  void initState() {
    super.initState();
    _getRoom();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Room: $locationOfRoom',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(height: 16),
          Text(
            '${widget.counter}/$numberOfObjects',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2899f3)),
          ),
          const SizedBox(height: 56),
          ButtonWidget(
            text: 'Continue scan',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const QRScanPage(),
            )),
            backgroundColor: const Color(0xFF404ccf),
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 16),
          ),
          const SizedBox(height: 16),
          ButtonWidget(
            text: 'Stop inventory',
            onClicked: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  //title: const Text('Title'),
                  content: const Text('Are you sure you want to stop the inventory?\n\nNote: pressing "Yes" saves an inventory record!'),
                  actions: <Widget> [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'No'),
                        child: const Text('No')
                    ),
                    TextButton(
                        onPressed: () => _stopInventory(),
                        child: const Text('Yes'),
                    ),
                  ],
                )
            ),
            backgroundColor: const Color(0xFF2899f3),
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 16),
          ),
        ],
      ),
    ),
  );
}