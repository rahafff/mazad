import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/InfoRow.dart';

class CustomerInformation extends StatelessWidget {
  final String name;
  final String zoneNumber;
  final String street;
  final String buildingNumber;
  const CustomerInformation({
    Key? key,
    required this.zoneNumber,
    required this.street,
    required this.name,
    required this.buildingNumber,
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
              AppStrings.orderAddress.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          InfoRow(
            value: name,
            title: AppStrings.fullName,
          ),
          InfoRow(
            value: zoneNumber,
            title: AppStrings.zoneNumber,
          ),
          InfoRow(
            value: street,
            title: AppStrings.street,
          ),
          InfoRow(
            value: buildingNumber,
            title: AppStrings.buildingNumber,
          ),
        ],
      ),
    );
  }
}
