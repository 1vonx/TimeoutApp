import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travell_app/misc/colors.dart';

import '../text/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  String? text;

  ResponsiveButton(
      {Key? key,
      this.width = 120,
      this.isResponsive = false,
      this.text = "Plan Trip Now"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.mainColor),
        child: Row(
          mainAxisAlignment: isResponsive == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            isResponsive == true
                ? Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: AppText(
                      text: text!.isEmpty ? "Plan Trip Now" : text!,
                      color: Colors.white,
                    ),
                  )
                : Container(),
            Image.asset("img/button-one.png"),
          ],
        ),
      ),
    );
  }
}
