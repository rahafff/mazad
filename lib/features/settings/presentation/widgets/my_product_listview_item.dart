import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/constant_backend_values.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/color_manager.dart';

class MyProductListviewItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String? ownerName;
  final int statusCode;
  final ProductStatus status = ProductStatus();
  final VoidCallback? onTap;
  final bool isMine;

  MyProductListviewItem({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.statusCode,
    this.onTap,
    this.ownerName,
    this.isMine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 20.h,
        child: Card(
          margin: EdgeInsets.symmetric(
            vertical: 2.h,
          ),
          elevation: 2,
          child: Row(
            children: [
              Padding(

                padding: EdgeInsets.all(2.w),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ExtendedImage.network(
                    image,
                    cacheWidth: 500,
                    cacheHeight: 500,
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.w),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Column(
                  children: [
                    SizedBox(
                      width: 30.w,
                      child: FittedBox(
                        alignment:
                            lang ? Alignment.centerLeft : Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          name,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: FittedBox(
                        alignment:
                            lang ? Alignment.centerLeft : Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          price,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: ColorManager.kGreen),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: FittedBox(
                        alignment:
                            lang ? Alignment.centerLeft : Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          ownerName ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: ColorManager.kGreen),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                child: Column(
                  children: [
                    isMine
                        ? Text.rich(
                            TextSpan(
                                text: "${AppStrings.status.tr()} : ",
                                children: [
                                  TextSpan(
                                      text: status.statusesNames[statusCode]?.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: status
                                                .statusesColors[statusCode],
                                          ),),
                                ]),
                          )
                        : Container(),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
