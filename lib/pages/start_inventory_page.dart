import 'package:flutter/material.dart';
import 'package:mobile_app/pages/process_inventory_page.dart';
import 'package:mobile_app/widgets/button_widget.dart';

import '../mysql.dart';

class StartInventoryPage extends StatefulWidget {
  const StartInventoryPage({Key? key}) : super(key: key);

  @override
  _StartInventoryPageState createState() => _StartInventoryPageState();
}

class _StartInventoryPageState extends State<StartInventoryPage> {
  var db = MySQL();
  var roomID = 'Unknown';
  var rooms = <String>[];
  String dropdownValue = 'Unknown';
  List<String> objects = [];

  Future<void> _getRooms() async {
    await db.getConnection().then((conn) async {
      var res = await conn.query('select location_of_room from room;');
      for (var row in res) {
        setState(() {
          rooms.add(row[0]);
        });
      }
      await conn.close();
    });
    dropdownValue = rooms[0];
    await _getRoomID();
  }

  Future<void> _getRoomID() async {
    await db.getConnection().then((conn) async {
      var res = await conn.query('select id_room from room where location_of_room = $dropdownValue;');
      for (var row in res) {
        setState(() {
          roomID = row[0].toString();
        });
      }
      await conn.close();
    });
  }

  @override
  void initState() {
    super.initState();
    _getRooms();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/process_illustration.png',
            width: 300,
            height: 230,
          ),
          const SizedBox(height: 16),
          const Text(
            'Please select your current room',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF878787)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 210,
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              elevation: 16,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  _getRoomID();
                });
              },
              items: rooms
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 32),
          ButtonWidget(
              text: 'Continue',
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProcessInventoryPage(room: int.parse(roomID), counter: 0, objects: objects),
              )),
              backgroundColor: const Color(0xFF404ccf),
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 92, vertical: 16),
          )
        ],
      ),
    ),
  );
}