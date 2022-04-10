import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_app/widgets/button_widget.dart';

import '../main.dart';

class StartInventoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StartInventoryPageState();
}

class _StartInventoryPageState extends State<StartInventoryPage> {
  String qrCode = 'Unknown';

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Scan Result',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white54,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '$qrCode',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 72),
          /*ButtonWidget(
            text: 'Start QR scan',
            onClicked: () => scanQRCode(),
          ),*/
        ],
      ),
    ),
  );

  Future<void> startInventory() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}