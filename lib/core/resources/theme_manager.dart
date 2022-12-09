import 'package:elite_auction/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // primarySwatch: MaterialColor,
    // primaryColorLight: ColorManager.kGreen,
    // shadowColor:ColorManager.kGreen ,
    accentColor: ColorManager.kWhite ,
    // buttonColor: ColorManager.kMove ,
    // accentTextTheme: TextTheme(subtitle1:TextStyle(color: Colors.white) ),
    // primaryIconTheme: IconThemeData(color: ColorManager.kMove),
    // accentIconTheme:IconThemeData(color:ColorManager.kGreen ) ,
    accentColorBrightness:  Brightness.dark,
    // hoverColor: ColorManager.kGreen,
      // main colors of the app
      primaryColor: ColorManager.primary,
      disabledColor: ColorManager.black,
      scaffoldBackgroundColor: ColorManager.kWhite,
      indicatorColor: ColorManager.primary,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ColorManager.primary,
        circularTrackColor: ColorManager.primary,
        linearTrackColor: ColorManager.primary,
      ),
      focusColor: Colors.transparent,
      tabBarTheme: TabBarTheme(
        overlayColor: MaterialStateProperty.all(ColorManager.kGreen),
      ),
      // ripple color
      splashColor: ColorManager.primary.withOpacity(0.7),
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.kWhite,
          shadowColor: ColorManager.lightGray,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.primary,
            systemNavigationBarColor: ColorManager.lightBlack),
        iconTheme: IconThemeData(color: ColorManager.kGreen, size: 8.0.w),
        centerTitle: true,
        color: ColorManager.kWhite,
        elevation: AppSize.s0,
        shadowColor: ColorManager.primary,
        titleTextStyle:
            getRegularStyle(color: ColorManager.primary, fontSize: FontSize.s16)
                .copyWith(overflow: TextOverflow.fade),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: ColorManager.kGreen,
        showUnselectedLabels: true,
        elevation: 5,
        unselectedItemColor: ColorManager.kMove,
        selectedLabelStyle: getRegularStyle(
          fontSize: 0,
          color: ColorManager.kGreen,
        ),
        selectedIconTheme: IconThemeData(color: ColorManager.kGreen, size: 8.w),
        unselectedIconTheme:
            IconThemeData(color: ColorManager.kMove, size: 8.w),
        unselectedLabelStyle: getRegularStyle(
          fontSize: 0,
          color: ColorManager.grayText,
        ),
      ),

      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.lightGray,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primary),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(const StadiumBorder()),
            backgroundColor: MaterialStateProperty.all(ColorManager.primary),
            padding: MaterialStateProperty.all(EdgeInsets.all(10)),
            textStyle: MaterialStateProperty.all(
              getRegularStyle(
                color: ColorManager.kWhite,
                fontSize: 14.sp,
              ),
            )),
        // elevation: 5,
        // backgroundColor: ColorManager.primary,
        // textStyle: getRegularStyle(
        //   color: ColorManager.kWhite,
        //   fontSize: 14.sp,
        // ),
        // shape: const StadiumBorder()
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorManager.primary,
          elevation: 7,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          foregroundColor: ColorManager.kWhite),

      // Text theme
      textTheme: TextTheme(
        headline1:
            getLightStyle(color: ColorManager.kMove, fontSize: FontSize.s20),
        headline2: getLightStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s18),
        subtitle1: getRegularStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s16),
        subtitle2: getRegularStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s14),
        bodyText1:
            getRegularStyle(color: ColorManager.lightBlack, fontSize: 12.sp),
        bodyText2:
            getRegularStyle(color: ColorManager.lightBlack, fontSize: 10.sp),
        caption: getRegularStyle(color: ColorManager.lightGray, fontSize: 8.sp),
      ),
      iconTheme: IconThemeData(color: ColorManager.kGreen, size: 8.w),
      inputDecorationTheme: InputDecorationTheme(
        // hint style
        hintStyle: getRegularStyle(
            color: ColorManager.lightGray, fontSize: FontSize.s12),

        // label style
        labelStyle:
            getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s12),
        // error style
        errorStyle:
            getRegularStyle(color: ColorManager.error, fontSize: FontSize.s8),

        // enabled border
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.lightGray, width: AppSize.s0),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.textFieldBorderRadius),
          ),
        ),
        suffixIconColor: ColorManager.kMove,

        // focused border
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.textFieldBorderRadius),
          ),
        ),
        // error border
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.textFieldBorderRadius),
          ),
        ),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSize.textFieldBorderRadius),
          ),
        ),
      ),
      useMaterial3: false,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w))),
          backgroundColor: MaterialStateProperty.all(ColorManager.kWhite),
          foregroundColor: MaterialStateProperty.all(ColorManager.primary),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          textStyle: MaterialStateProperty.all(
            TextStyle(
                color: ColorManager.kWhite,
                fontSize: FontSize.s14,
                fontFamily: FontConstants.fontFamily),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all(ColorManager.midumeGray),
        thumbColor: MaterialStateProperty.all(ColorManager.kMove),
      ),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorManager.kMove,
          selectionColor: ColorManager.primary,
          selectionHandleColor: ColorManager.primary),
      backgroundColor: ColorManager.kWhite);
}
