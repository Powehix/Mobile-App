import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_app/pages/error_incorrect_page.dart';
import 'package:mobile_app/pages/finish_inventory_page.dart';
import 'package:mobile_app/pages/process_inventory_page.dart';
import 'package:mobile_app/pages/qr_result_page.dart';
import 'package:vibration/vibration.dart';

import '../main.dart';
import '../mysql.dart';
import 'error_unknown_page.dart';

class ScanInventoryPage extends StatefulWidget {
  final int room;
  final int counter;
  final Function(int counter) updateCounter;
  const ScanInventoryPage({Key? key, required this.room, required this.counter, required this.updateCounter}) : super(key: key);

  @override
  _ScanInventoryPageState createState() => _ScanInventoryPageState();
}

class _ScanInventoryPageState extends State<ScanInventoryPage> {
  var db = MySQL();
  var roomID = 'Unknown';
  late int numberOfObjects;
  late String scanResult;

  Future<void> scanQR() async {
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#404ccf',
          'Cancel',
          true,
          ScanMode.QR);
    } on PlatformException {
      scanResult = 'Failed to get platform version.';
    }

    if (!mounted) return;

    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 100);
    }

    if (int.tryParse(scanResult) == null) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ErrorUnknownPage()
        ));
      });
    } else if (scanResult == '-1') {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProcessInventoryPage(room: widget.room, counter: widget.counter)
      ));
    } else {
      _getRoomID();
      if (roomID == widget.room) {
        _countObjects();
        scanQR();
      } else {
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => const ErrorIncorrectPage()
          ));
        });
      }
    }
  }

  void _getRoomObjects() {
    db.getConnection().then((conn) {
      String sql = 'select number_of_objects from room where id_room = ${widget.room};';
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            numberOfObjects = row[0];
          });
        }
      });
    });
  }

  void _getRoomID() {
    db.getConnection().then((conn) {
      String sql = 'select id_room from object where id_object = $scanResult;';
      conn.query(sql).then((results) {
        for (var row in results) {
          setState(() {
            roomID = row[0].toString();
          });
        }
      });
    });
  }

  void _countObjects() {
    //count variable, check for limit and return back to the process inventory page
    int counterUpdate = widget.counter;
    counterUpdate++;
    widget.updateCounter(counterUpdate);
    if (counterUpdate == numberOfObjects) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => FinishInventoryPage(room: widget.room,)));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //widget.updateCounter(widget.counter);
    _getRoomObjects();
    scanQR();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
          ],
        ),
      )
  );
}
