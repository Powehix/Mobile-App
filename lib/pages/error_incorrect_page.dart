import 'package:flutter/material.dart';

class ErrorIncorrectPage extends StatefulWidget {
  const ErrorIncorrectPage({Key? key}) : super(key: key);

  @override
  _ErrorIncorrectPageState createState() => _ErrorIncorrectPageState();
}

class _ErrorIncorrectPageState extends State<ErrorIncorrectPage> {
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
                'The object is listed in another room.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ]),
      )
  );
}