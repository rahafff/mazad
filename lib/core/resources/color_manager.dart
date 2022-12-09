import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xFF4E8075);
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color lightBlack = HexColor.fromHex("#4A4A4A");
  static Color lightGrayButtonColor = HexColor.fromHex("#eaeceb");
  static Color midumeGrayButtonColor = HexColor.fromHex("#e5e6e8");
  static const kGreen = Color.fromARGB(255, 78, 128, 117);
  static const kMove = Color.fromARGB(255, 126, 76, 80);
  static const kWhite = Colors.white;
  static Color kWhiteWithAlpha90 = Colors.white.withAlpha(90);
  static const kBlack = Colors.black;
  static Color shimmerBaseColor = Colors.grey[200]!;
  static Color shimmerHighlightColor = Colors.grey[100]!;

  static Color kPending = HexColor.fromHex('#dc3545');
  static Color kPendingProduct = HexColor.fromHex('#b8c2cc');
  static Color kAccepted = HexColor.fromHex('#ffc107');
  static Color kDelivering = HexColor.fromHex('#ffc107');
  static Color kDelivered = HexColor.fromHex('#28a745');
  static Color kCanceled = HexColor.fromHex('#df4759');
  static Color kRejected = HexColor.fromHex('#ea5455');
  static Color scaffoldColor = HexColor.fromHex('#f2f2f2');
  static Color grayText = HexColor.fromHex('#a6a6a8');
  static Color lightGray = HexColor.fromHex('#F9F9F9');
  static Color midumeGray = HexColor.fromHex('#a6a6a8');

  // new colors
  static Color error = HexColor.fromHex("#e61f34");
  static Color black = HexColor.fromHex("#000000"); // red color
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
