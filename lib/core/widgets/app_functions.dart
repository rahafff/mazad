import 'package:flutter/cupertino.dart';

class AppFunctions {
  static VoidCallback? unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
    return null;
  }
}
