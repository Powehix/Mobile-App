import 'package:flutter/material.dart';

class ProcessInventoryPage extends StatefulWidget {
  const ProcessInventoryPage({Key? key}) : super(key: key);

  @override
  _ProcessInventoryPageState createState() => _ProcessInventoryPageState();
}

class _ProcessInventoryPageState extends State<ProcessInventoryPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Some text',
          )
        ],
      ),
    ),
  );
}