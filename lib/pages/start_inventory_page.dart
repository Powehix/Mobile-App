import 'package:flutter/material.dart';
import 'package:mobile_app/pages/process_inventory_page.dart';
import 'package:mobile_app/widgets/button_widget.dart';

class StartInventoryPage extends StatefulWidget {
  const StartInventoryPage({Key? key}) : super(key: key);

  @override
  _StartInventoryPageState createState() => _StartInventoryPageState();
}

class _StartInventoryPageState extends State<StartInventoryPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/process_illustration.jpg',
            width: 300,
            height: 230,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your current room',
              ),
            ),
          ),
          ButtonWidget(
              text: 'Continue',
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const ProcessInventoryPage(),
              )),
              backgroundColor: const Color(0xFF404ccf),
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 16),
          )
        ],
      ),
    ),
  );
}