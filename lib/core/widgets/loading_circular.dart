import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class LoadingCircularWidget extends StatefulWidget {
  @override
  _LoadingCircularWidgetState createState() => _LoadingCircularWidgetState();
}

class _LoadingCircularWidgetState extends State<LoadingCircularWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: ColorManager.kMove,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
    );
  }
}
