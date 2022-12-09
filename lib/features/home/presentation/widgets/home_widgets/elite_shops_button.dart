import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/utils/global.dart';
import '../../../../../core/widgets/sized_box_functions.dart';

class EliteShopsButton extends StatelessWidget {
  const EliteShopsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // todo refactor
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.shopsRoute);
        // print(AppSize.screenSize(context));
      },
      child: Container(
        alignment: lang ? Alignment.centerLeft : Alignment.centerLeft,
        height: 15.h,
        margin: EdgeInsets.symmetric(horizontal: 2.5.w),
        decoration: BoxDecoration(
          // boxShadow: const [
          //   BoxShadow(
          //     offset: Offset(0, 4),
          //     blurRadius: 2,
          //     color: ColorManager.kMove,
          //   )
          // ],
          color: const Color(0xfff7f7f8),
          borderRadius: BorderRadius.circular(3.0.w),
          shape: BoxShape.rectangle,
          image: const DecorationImage(
              image: AssetImage(
                ImageAssetsManager.bannerBackground,
              ),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageIcon(
                    const AssetImage(ImageAssetsManager.addToCartForBanner),
                    color: ColorManager.kWhite,
                    size: 0.00009 * AppSize.screenSize(context),
                  ),
                  if (lang)
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 0.00005 * AppSize.screenSize(context),
                        ),
                        SizedBoxFunctions.horizontalSizedBox(0.1),
                        Text(AppStrings.eliteShopsCapitalized.tr(),
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorManager.kWhite,
                                      fontWeight: FontWeight.bold,
                                    )),
                      ],
                    ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 10.w,
                    height: 6.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageAssetsManager.bannerLogo)),
                    ),
                  ),
                  const Spacer(),
                  if (!lang)
                    Row(
                      children: [
                        Text(AppStrings.eliteShopsCapitalized.tr(),
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorManager.kWhite,
                                      fontWeight: FontWeight.bold,
                                    )),
                        SizedBoxFunctions.horizontalSizedBox(0.1),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 0.00005 * AppSize.screenSize(context),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
