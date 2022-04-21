import 'package:flutter/material.dart';

class ErrorUnknownPage extends StatefulWidget {
  const ErrorUnknownPage({Key? key}) : super(key: key);

  @override
  _ErrorUnknownPageState createState() => _ErrorUnknownPageState();
}

class _ErrorUnknownPageState extends State<ErrorUnknownPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFF404ccf),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Error!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'Object not found.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
        ]),
      )
  );
}