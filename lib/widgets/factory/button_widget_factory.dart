import 'package:flutter/cupertino.dart';

import '../buttons/custom_button.dart';

abstract class ButtonWidgetFactory{
  Widget createButton(VoidCallback onPressed, String label);
}

class iOSButtonFactory implements ButtonWidgetFactory{
  @override
  Widget createButton(VoidCallback onPressed,String label) {
    return CupertinoButton(
        child: Text(label),
        onPressed: onPressed);
  }
}

class AndroidButtonFactory implements ButtonWidgetFactory{
  @override
  Widget createButton(VoidCallback onPressed, String label) {
    return CustomButton(onPressed: onPressed, label: label);
  }
}