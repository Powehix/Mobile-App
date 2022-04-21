import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/button_widget.dart';

class FinishInventoryPage extends StatefulWidget {
  final int room;
  const FinishInventoryPage({Key? key, required this.room}) : super(key: key);

  @override
  _FinishInventoryPageState createState() => _FinishInventoryPageState();
}

class _FinishInventoryPageState extends State<FinishInventoryPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFF404ccf),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/success_illustration.png',
                width: 200,
                height: 100,
              ),
              const SizedBox(height: 36),
              const Text(
                'All objects are scanned!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'The result of the inventory has been saved.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              ButtonWidget(
                text: 'Return home',
                onClicked: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const MainPage()
                )),
                backgroundColor: const Color(0xFF7480fd),
                textColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
              ),
            ]),
      )
  );
}