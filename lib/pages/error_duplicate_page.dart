import 'package:flutter/material.dart';

class ErrorDuplicatePage extends StatefulWidget {
  const ErrorDuplicatePage({Key? key}) : super(key: key);

  @override
  _ErrorDuplicatePageState createState() => _ErrorDuplicatePageState();
}

class _ErrorDuplicatePageState extends State<ErrorDuplicatePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFF404ccf),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Error!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'This object has already been scanned.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ]),
      )
  );
}