import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/color_manager.dart';

class TimeCard extends StatelessWidget {
  TimeCard({
    required this.time,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0.w,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: ColorManager.kGreen, spreadRadius: 1)]),
      child: Center(
        child: Text(
          time,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: ColorManager.kGreen),
        ),
      ),
    );
  }
}
