import 'package:flutter/material.dart';
import 'package:travell_app/widgets/buttons/responsive_button.dart';

class CustomButton extends StatelessWidget {
  var onPressed;
  String label;

  CustomButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        child: Row(children: [
          ResponsiveButton(
            width: 100,
            text: label,
          )
        ]),
      ),
    );
  }
}
