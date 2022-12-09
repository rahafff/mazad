import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class LoadingLinearWidget extends StatefulWidget {
  const LoadingLinearWidget({Key? key}) : super(key: key);

  @override
  _LoadingLinearWidgetState createState() => _LoadingLinearWidgetState();
}

class _LoadingLinearWidgetState extends State<LoadingLinearWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LinearProgressIndicator(
        backgroundColor: ColorManager.kMove,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
    );
  }
}
