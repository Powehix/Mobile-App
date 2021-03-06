import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsets padding;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    required this.backgroundColor,
    required this.textColor,
    required this.padding,
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
    color: backgroundColor,
    padding: padding,
    textColor: textColor,
    onPressed: onClicked,
    elevation: 0,
    hoverElevation: 0,
    focusElevation: 0,
    highlightElevation: 0,
  );
}