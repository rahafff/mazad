import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/global.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 35.0.w,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
            child: Text('${title.tr()} :',
                style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
        SizedBox(
          width: 40.0.w,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: lang ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(value, style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
      ],
    );
  }
}
