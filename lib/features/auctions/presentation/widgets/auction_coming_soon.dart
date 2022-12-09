import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/strings_manager.dart';

class AuctionComingSoon extends StatelessWidget {
  const AuctionComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.auctions.tr(),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: Center(
            child: Image.asset(ImageAssetsManager.soonForAuction),
          ),
        ),
      ),
    );
  }
}
