// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/pages/qr_scan_page.dart';
import 'package:mobile_app/pages/start_inventory_page.dart';
import 'package:mobile_app/widgets/button_widget.dart';

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

  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      fontFamily: 'Inter',
      scaffoldBackgroundColor: Colors.white,
      //hintColor: Colors.black,
    ),

    home: const MainPage(),
  );
}

class MainPage extends StatefulWidget {

  const MainPage({
    Key key
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/inventory_illustration.png',
            width: 400,
            height: 330,
          ),
          const Text(
            'Welcome',
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            width: 300,
              child: Text(
                'This is an inventory management application. Please select what you want to do.',
                style: TextStyle(fontSize: 14, color: Color(0xFF878787), fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
          ),
          const SizedBox(height: 56),
          ButtonWidget(
            text: 'Start inventory',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const StartInventoryPage(),
            )),
            backgroundColor: const Color(0xFF404ccf),
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 16),
          ),
          const SizedBox(height: 16),
          ButtonWidget(
            text: 'Scan QR code',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const QRScanPage(),
            )),
            backgroundColor: const Color(0xFFc9f3fe),
            textColor: const Color(0xFF406fcf),
            padding: const EdgeInsets.symmetric(horizontal: 76, vertical: 16),
          ),
          const SizedBox(height: 12),
          const SizedBox(
            width: 250,
            child: Text(
              'Please note that the application requires internet access.',
              style: TextStyle(fontSize: 12, color: Color(0xFF878787), fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}
