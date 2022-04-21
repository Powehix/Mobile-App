import 'package:flutter/material.dart';

class FinishInventoryPage extends StatefulWidget {
  final int room;
  const FinishInventoryPage({Key? key, required this.room}) : super(key: key);

  @override
  _FinishInventoryPageState createState() => _FinishInventoryPageState();
}

class _FinishInventoryPageState extends State<FinishInventoryPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFF404ccf),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'All objects are scanned! The result of the inventory has been saved.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ]),
      )
  );
}