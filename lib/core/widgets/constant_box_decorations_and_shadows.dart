import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class ConstantBoxDecorationsAndShadows {
  static BoxDecoration circularBoxWithDarkShadow = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 5,
        blurRadius: 9,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
    borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
  );
  static BoxShadow darkShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 5,
    blurRadius: 9,
    offset: Offset(0, 3), // changes position of shadow
  );

  static BoxDecoration RoundedBoxWithLightShadow = BoxDecoration(
    shape: BoxShape.rectangle,
    color: Colors.white,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 0.5,
        blurRadius: 5,
      ),
    ],
    borderRadius: BorderRadius.all(Radius.circular(6.0.w)),
  );
  static BoxDecoration circularBoxWithExtraLightShadow = BoxDecoration(
    shape: BoxShape.rectangle,
    color: Colors.white,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 0.5,
        blurRadius: 2,
      ),
    ],
    borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
  );

  static BoxShadow lightShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 0.5,
    blurRadius: 2,
  );
  static InputDecoration searchFieldInputDecoration = InputDecoration(
    // hint style
    hintStyle:
        getRegularStyle(color: ColorManager.midumeGray, fontSize: FontSize.s12),
    hintText: AppStrings.search.tr(),

    // error style
    errorStyle:
        getRegularStyle(color: ColorManager.error, fontSize: FontSize.s8),

    // enabled border
    enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.lightGray, width: AppSize.s0),
        borderRadius: BorderRadius.circular(20.0.w)),
    filled: true,
    // focused border
    focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16))),
    // error border
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16))),
    // focused error border
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16))),
  );
}
