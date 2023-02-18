import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  double size;
  bool hasUnderline;
  bool isBold;
  final String text;
  final Color color;
  AppText({Key? key,
    this.size=16,
    this.hasUnderline = false,
    this.isBold = true,
    required this.text,
    this.color=Colors.black54}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color:color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          decoration: hasUnderline ? TextDecoration.underline : TextDecoration.none
      ),
    );
  }
}