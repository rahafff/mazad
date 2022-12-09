import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:elite_auction/features/splash/domain/entities/version_entity.dart';
import 'package:elite_auction/features/splash/presentation/manager/application_version_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/login_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/logout_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_update_dialog/update_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/error/network_exceptions.dart';
import '../../../../core/global_states/standard_state.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../settings/presentation/manager/currency_cubit.dart';
import '../../../user/domain/bodies/login_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String _appUrl =
      Platform.isAndroid ? EndPoints.playStoreUrl : EndPoints.appleStoreUrl;

  late UpdateDialog dialog;

  void updateApp() async {
    if (!await launchUrl(
      Uri.parse(_appUrl),
    )) throw 'Could not launch $_appUrl';
  }

  @override
  void initState() {
    context.read<ApplicationVersionCubit>().emitGetAppVersion();
    context.read<CurrencyCubit>().emitGetCurrencies();
    if (!isTokenExist) return;
    if (AppSharedPreferences.accessPassword == null) {
      context.read<LogoutCubit>().logout();
      return;
    }
    context.read<LoginCubit>().emitLogin(
          LoginBody(
              password: AppSharedPreferences.accessPassword,
              phoneNumber: AppSharedPreferences.accessPhone,
              fcmToken: AppSharedPreferences.fcmToken),
        );
    super.initState();
  }

  void startTimer() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(
            context, Routes.bottomNavigationBarRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(
                ImageAssetsManager.splash,
              ),
            ),
          ),
          child: buildDialogForUpdate(),
        ),
      ),
    );
  }

  buildDialogForUpdate() {
    return BlocListener<ApplicationVersionCubit, StandardState<VersionEntity?>>(
      listener: (context, state) {
        if (Platform.isAndroid) {
          state.whenOrNull(
            success: (data) {
              if (kDebugMode) {
                print("android build number ${data?.androidBuildNumber}");
              }
              if (data?.androidBuildNumber !=
                  context.read<ApplicationVersionCubit>().buildNumber) {
                dialog = _buildShowUpdate(
                    context: context,
                    title: AppStrings.googlePlayUpdateMessage.tr(),isIos: false);
              } else {
                startTimer();
              }
            },
            error: (networkExceptions) => Fluttertoast.showToast(
              msg: NetworkExceptions.getErrorMessage(networkExceptions),
            ),
          );
        } else if (Platform.isIOS) {
          state.whenOrNull(
            success: (data) {
              if (kDebugMode) {
                print("ios build number ${data?.iosBuildNumber}");
              }
              if (data?.iosBuildNumber !=
                  context.read<ApplicationVersionCubit>().buildNumber) {
                dialog = _buildShowUpdate(
                    context: context, title: AppStrings.appleUpdateMessage.tr(),isIos: true);
              } else {
                startTimer();
              }
            },
            error: (networkExceptions) => Fluttertoast.showToast(
              msg: NetworkExceptions.getErrorMessage(networkExceptions),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  UpdateDialog _buildShowUpdate(
      {required BuildContext context, required String title, bool isIos=false}) {
    return UpdateDialog.showUpdate(context,
        title: title.tr(),
        updateContent: "",
        titleTextSize: 14.sp,
        contentTextSize: 12.sp,
        buttonTextSize: 12.sp,
        topImage: Image.asset(ImageAssetsManager.dialogLogo,height: isIos? 60.h: null,fit: BoxFit.fill,),
        // extraHeight: 5,
        radius: 8,
        themeColor: ColorManager.kGreen,
        progressBackgroundColor: ColorManager.kMove,
        isForce: true,
        updateButtonText: AppStrings.update.tr(),
        ignoreButtonText: AppStrings.close.tr(),
        enableIgnore: true, onIgnore: () {
      Navigator.pushReplacementNamed(context, Routes.bottomNavigationBarRoute);
    }, onUpdate: updateApp);
  }
}
