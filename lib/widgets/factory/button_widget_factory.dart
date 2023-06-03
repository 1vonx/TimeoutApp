import 'package:flutter/cupertino.dart';

import '../buttons/custom_button.dart';

abstract class ButtonWidgetFactory{
  Widget createButton(VoidCallback onPressed, String label);
}

class iOSButtonFactory implements ButtonWidgetFactory{
  @override
  Widget createButton(VoidCallback onPressed,String label) {
    return CupertinoButton(
        onPressed: onPressed,
        child: Text(label));
  }
}

class AndroidButtonFactory implements ButtonWidgetFactory{
  @override
  Widget createButton(VoidCallback onPressed, String label) {
    return CustomButton(onPressed: onPressed, label: label);
  }
}