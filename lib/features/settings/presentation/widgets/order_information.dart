import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../core/widgets/InfoRow.dart';

class OrderInformation extends StatelessWidget {
  final String orderTrackCode;
  final String paymentStatus;
  final String paymentMethod;
  final String orderStatus;
  final String createdAt;
  const OrderInformation({
    Key? key,
    required this.orderTrackCode,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.orderStatus,
    required this.createdAt,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 3.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              AppStrings.orderInformation.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          InfoRow(
            value: orderTrackCode,
            title: AppStrings.yourOrderTrackCode,
          ),
          InfoRow(
            value: paymentStatus.tr(),
            title: AppStrings.paymentStatus,
          ),
          InfoRow(
            value: paymentMethod.tr(),
            title: AppStrings.paymentMethod,
          ),
          InfoRow(
            value: orderStatus.tr(),
            title: AppStrings.orderStatus,
          ),
          InfoRow(
            value: createdAt,
            title: AppStrings.createdAt,
          ),
        ],
      ),
    );
  }
}
