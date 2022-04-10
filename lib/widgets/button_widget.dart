import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    //shape: StadiumBorder(),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),
    //color: Theme.of(context).primaryColor,
    color: const Color(0xFF404ccf),
    padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 16),
    textColor: Colors.white,
    onPressed: onClicked,
  );
}