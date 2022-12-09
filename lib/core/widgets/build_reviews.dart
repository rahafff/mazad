import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/global.dart';

class BuildReviews extends StatelessWidget {
  const BuildReviews({
    Key? key,
    @required this.average,
    @required this.reviews,
    required this.width,
    required this.starSize,
    this.fontSize,
  }) : super(key: key);

  final num? average;
  final int? reviews;
  final double width;
  final double starSize;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: starSize,
            ),
            Text(
                ' ${average ?? 0.0}'
                ' (${AppStrings.reviewers.tr()} : ${reviews ?? 0})',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorManager.kMove, fontSize: fontSize ?? 10.0.sp)),
          ],
        ),
      ),
    );
  }
}
