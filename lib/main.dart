import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/pages/qr_scan_page.dart';
import 'package:mobile_app/pages/start_inventory_page.dart';
import 'package:mobile_app/widgets/button_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Inventory Management';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      fontFamily: 'Inter',
      scaffoldBackgroundColor: Colors.white,
      hintColor: Colors.black,
    ),

    home: const MainPage(title: title),
  );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
    Key? key
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _scanQR = 'Unknown';

  Future<void> scanQR() async {
    String scanRes;
    try {
      scanRes = await FlutterBarcodeScanner.scanBarcode(
          '#404ccf', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      scanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanQR = scanRes;
    });

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => QRScanPage(result: _scanQR)
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/inventory_illustration.jpg',
            width: 400,
            height: 330,
          ),
          Container(
            height: 40.00,
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Welcome",
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 300.00,
            height: 50.00,
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "This is an inventory management application. Please select what you want to do.",
              ),
              textAlign: TextAlign.center,
              maxLines: 5,
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          const SizedBox(height: 32),
          ButtonWidget(
            text: 'Start inventory',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => StartInventoryPage(),
            )),
          ),
          const SizedBox(height: 16),
          ButtonWidget(
            text: 'Scan QR code',
            onClicked: () => scanQR(),
            /*onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const QRScanPage(),
            )),*/
          ),
        ],
      ),
    ),
  );
}
