import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/constant_box_decorations_and_shadows.dart';
import '../../../../core/widgets/sized_box_functions.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({
    Key? key,
    required this.cardTitle,
    required this.cardContent,
  }) : super(key: key);
  final String cardTitle;
  final Widget cardContent;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 3.w),
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardTitle,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBoxFunctions.verticalSizedBox(1),
          cardContent
        ],
      ),
    );
  }
}
