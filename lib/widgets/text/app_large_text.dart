import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double size;
  bool isBold;
  final String text;
  final Color color;
   AppLargeText({Key? key,
     this.size=30,
     this.isBold=false,
     required this.text,
     this.color=Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color:color,
        fontSize: size,
        fontWeight: isBold==true ? FontWeight.bold : FontWeight.normal
      ),
    );
  }
}
