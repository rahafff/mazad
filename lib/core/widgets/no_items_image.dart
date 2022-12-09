import 'package:elite_auction/core/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/assets_manager.dart';

class NoItemsWidget extends StatelessWidget{
  const NoItemsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(lang? ImageAssetsManager.noItemEn:ImageAssetsManager.noItemAr,height: 60.h,
        width: 60.w,),
    );

  }
}