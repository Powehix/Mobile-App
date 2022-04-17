import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_app/pages/qr_result_page.dart';

import '../main.dart';
import 'error_page.dart';

class ScanInventoryPage extends StatefulWidget {
  final int counter;
  const ScanInventoryPage({Key? key, required this.counter}) : super(key: key);

  @override
  _ScanInventoryPageState createState() => _ScanInventoryPageState();
}

class _ScanInventoryPageState extends State<ScanInventoryPage> {
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

    if (int.tryParse(scanResult) == null) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ErrorPage()));
      });
    } else if (scanResult == '-1') {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const MainPage()
      ));
    } else {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => QRResultPage(result: scanResult)
      ));
    }
  }

  @override
  void initState() {
    super.initState();
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
