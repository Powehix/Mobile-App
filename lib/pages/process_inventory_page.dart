import 'package:flutter/material.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/pages/scan_inventory_page.dart';

import '../mysql.dart';
import '../widgets/button_widget.dart';

class ProcessInventoryPage extends StatefulWidget {
  final int room;
  final int counter;
  final List<String> objects;
  const ProcessInventoryPage({Key? key, required this.room, required this.counter, required this.objects}) : super(key: key);

  @override
  _ProcessInventoryPageState createState() => _ProcessInventoryPageState();
}

class _ProcessInventoryPageState extends State<ProcessInventoryPage> {
  var db = MySQL();
  var numberOfObjects = 'Unknown';
  var locationOfRoom = 'Unknown';
  var objectsAll = <String>[];
  var objectsMissed = <String>[];

  void _getRoom() {
    db.getConnection().then((conn) {
      String sql = 'select number_of_objects, location_of_room from room where id_room = ${widget.room};';
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

  void _getObjectsMissed() async {
    await db.getConnection().then((conn) async {
      var res = await conn.query('select id_object from object where id_room = ${widget.room};');
      for (var row in res) {
        setState(() {
          objectsAll.add(row[0].toString());
        });
      }
      objectsMissed = objectsAll.toSet().difference(widget.objects.toSet()).toList();
      await conn.close();
    });

  }

  void _stopInventory() {
    DateTime now = DateTime.now();
    DateTime date = DateTime.utc(now.year, now.month, now.day);

    db.getConnection().then((conn) async {
      await conn.query('insert into inventory (date, result, id_room) values (?, ?, ?)',
          [date, 'Objects with ID $objectsMissed are missed', widget.room]);
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
    _getObjectsMissed();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Room:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            locationOfRoom,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF7480fd)),
          ),
          const SizedBox(height: 16),
          const Text(
            'Scanned objects:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.counter}/$numberOfObjects',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF7480fd)),
          ),
          const SizedBox(height: 56),
          ButtonWidget(
            text: 'Scan QR codes',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ScanInventoryPage(room: widget.room, counter: widget.counter, updateCounter: (newCounter) {
                setState(() {
                  newCounter = widget.counter;
                });
              },
                objects: widget.objects,
              ),
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
                  content: const Text(
                    'Are you sure you want to stop the inventory?\n\nNote: pressing "Yes" saves an inventory record!',
                  ),
                  actions: <Widget> [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'No'),
                        child: const Text('No', style: TextStyle(color: Color(0xFF404ccf)))
                    ),
                    TextButton(
                        onPressed: () => _stopInventory(),
                        child: const Text('Yes', style: TextStyle(color: Color(0xFF404ccf))),
                    ),
                  ],
                )
            ),
            backgroundColor: const Color(0xFF7480fd),
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 73, vertical: 16),
          ),
        ],
      ),
    ),
  );
}