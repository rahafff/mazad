import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/global.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/sized_box_functions.dart';
import '../../domain/entities/my_product_details_entity.dart';

class MyProductDetails extends StatefulWidget {
  final MyProductDetailsEntity product;

  const MyProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<MyProductDetails> createState() => _MyProductDetailsState();
}

class _MyProductDetailsState extends State<MyProductDetails> {
  @override
  void dispose() {
    isCustomerScreen = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
      color: ColorManager.kWhite,
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 2.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 6.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 40.0.w, //55
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                      lang ? Alignment.centerLeft : Alignment.centerRight,
                  child: Text(
                   lang? widget.product.productDetails![0].productName.toString():
                   widget.product.productDetails![1].productName.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ), //name
              if(isCustomerScreen==false)
                productStatus(context, statusCode: widget.product.productStatus?.productStatusCode, expiredDate: widget.product.expiredDate,productNote: lang? widget.product.productDetails![0].productNote:widget.product.productDetails![1].productNote),// product status
            ],
          ),
        ),
        // const Divider(),
        Builder(builder: (context) {
          return SizedBox(
            width: 30.0.w,
            child: FittedBox(
              alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  text: widget.product.productPrice.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: lang?"Qar":"ريال قطري",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        }), //product price
        Builder(builder: (context) {
          return SizedBox(
            width: 30.0.w,
            child: FittedBox(
              alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  text: widget.product!.productQuantity.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }), //product quantity
        if (widget.product.subcategoryProduct!=null) //sub subcategory
          SizedBox(
          width: 55.0.w,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(lang? widget.product.subcategoryProduct!.subcategoryDetails![0].subcategoryName:
            widget.product.subcategoryProduct!.subcategoryDetails![1].subcategoryName,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ), // subcategory
        if (widget.product.subsubcategoryProduct != null) //sub subcategory
          SizedBox(
            width: 55.0.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(lang?widget.product.subsubcategoryProduct!.subsubcategoryDetails![0].subsubcategoryName:
              widget.product.subsubcategoryProduct!.subsubcategoryDetails![1].subsubcategoryName,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ), //sub subcategory
        if (widget.product.productDetails![0]?.productDescription !=
            null) //sub subcategory
          SizedBox(
            width: 55.0.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(lang?widget.product.productDetails![0].productDescription.toString():
              widget.product.productDetails![1].productDescription.toString(),
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ), //sub subcategory
        const Divider(),
        isCustomerScreen == false
            ? Container(
                width: double.infinity,
                height: 8.h,
                alignment: lang ? Alignment.center : Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xfff7f7f8),
                  borderRadius: BorderRadius.circular(3.0.w),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment:
                            lang ? Alignment.centerLeft : Alignment.centerRight,
                        child: Text(
                            "${AppStrings.myName.tr()} : ${widget.product.user?.fullName}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: ColorManager.kGreen)),
                      ), //owner name
                      FittedBox(
                        // RichText
                        fit: BoxFit.scaleDown,
                        alignment:
                            lang ? Alignment.centerLeft : Alignment.centerRight,
                        child: Text(
                            "${AppStrings.myNumber.tr()} : ${widget.product.customerPhone}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: ColorManager.kGreen)),
                      ) //owner number
                    ]),
              )
            : //light
            Container(
                height: 8.h,
                width: double.infinity,
                alignment: lang ? Alignment.center : Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.kGreen,
                  borderRadius: BorderRadius.circular(3.0.w),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment:
                            lang ? Alignment.centerLeft : Alignment.centerRight,
                        child: Text(
                            "${AppStrings.owner.tr()} : ${widget.product.user?.fullName}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: ColorManager.kWhite)),
                      ), //owner name
                      FittedBox(
                        // RichText
                        fit: BoxFit.scaleDown,
                        alignment:
                            lang ? Alignment.centerLeft : Alignment.centerRight,
                        child: RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchUrl(Uri.parse(
                                    "tel: ${widget.product.customerPhone}")),
                              text:
                                  "${AppStrings.contactUs.tr()} ${widget.product.customerPhone}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: ColorManager.kWhite)),
                        ),
                      ) //owner number
                    ]),
              ), //green
      ]),
    );
  }
}

Widget productStatus(context,{int? statusCode,String? expiredDate,String? productNote}) {
  if (statusCode == 1)
  {
    return Builder(
      builder: (context) {
        stringToDateTimeParser() {
          DateTime durationAsString = DateTime.parse(expireDate!);
          Duration duration = durationAsString.difference(DateTime.now());
          return duration.inDays;
        }
        int duration=stringToDateTimeParser();
        return SizedBox(
          width: 30.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 0.5.h),
              SizedBox(
                width: 15.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                  lang ? Alignment.centerLeft : Alignment.centerRight,
                  child: Text(
                    AppStrings.accepted.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: ColorManager.kGreen),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
                child: lang? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: lang
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        '${duration.toString()} ${AppStrings.days.tr()}',
                        style:
                        Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.grayText,
                        ),
                      ),
                    ),
                    SizedBoxFunctions.horizontalSizedBox(0.2.w),
                    Icon(
                      Icons.watch_later,
                      size: 0.00006 * AppSize.screenSize(context),
                      color: ColorManager.grayText,
                    )
                  ],
                ):
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.watch_later,
                      size: 0.00006 * AppSize.screenSize(context),
                      color: ColorManager.grayText,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: lang
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Text(
                        ' ${duration.toString()} ${AppStrings.days.tr()}',
                        style:
                        Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.grayText,
                        ),
                      ),
                    ),
                    SizedBoxFunctions.horizontalSizedBox(0.2.w),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  } else if (statusCode == 0) {
    return SizedBox(
      width: 25.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.5.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(
              AppStrings.rejected.tr(),
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: ColorManager.kCanceled),
            ),
          ),
          if(productNote!=null)
            GestureDetector(
              onTap: (){
                 showDialog(
                  context: context,
                  builder: (context) {
                    return  AppDialog(dialogText: productNote,buttonText: AppStrings.ok, buttonFunction: () {  Navigator.pop(context);});
                  });
              },
              child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: lang
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                AppStrings.seeDetails.tr(),
                style:
                Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.kCanceled,
                ),
              ),
          ),
            ),
        ],
      ),
    );
  } else {
    return SizedBox(
      height: 5.h,
      width: 15.w,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
        child: Text(
          AppStrings.pending.tr(),
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              fontWeight: FontWeight.bold, fontSize: 13, color: ColorManager.kPendingProduct),
        ),
      ),
    );
  }
}
