import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/delete_account_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/resources/bottom_navigation_bar_Items_Ids.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/widgets/sized_box_functions.dart';
import '../manager/currency_cubit.dart';
import '../manager/language_cubit.dart';
import '../widgets/language_switcher.dart';
import '../widgets/settings_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    context.read<CurrencyCubit>().emitGetCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageCubit, LanguageState>(
        listener: (context, state) {
          context.read<CurrencyCubit>().emitGetCurrencies();
          Fluttertoast.showToast(
              msg: AppStrings.langNow.tr(), toastLength: Toast.LENGTH_SHORT);
          setState(() {});
        },
        listenWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is EnglishLanguage) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(AppStrings.settings.tr()),
                  automaticallyImplyLeading: false,
                ),
                body: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    if (isTokenExist) ...[
                      SettingsItem(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.myProfileRoute);
                        },
                        title: AppStrings.myProf.tr(),
                        trailing:  Icon(
                          Icons.person,
                          size: AppSize.settingsIconSize,
                        ),
                      ),
                      SettingsItem(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.ordersRout);
                        },
                        title: AppStrings.myOrd.tr(),
                        trailing:  Icon(
                          Icons.shopping_cart_outlined,
                          size: AppSize.settingsIconSize,
                        ),
                      ),
                      //todo we will need this when activating auctions
                      // SettingsItem(
                      //   title: AppStrings.myAuctionOrd.tr(),
                      //   trailing: const ImageIcon(
                      //     AssetImage(ImageAssetsManager.auction),
                      //   ),
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => MyAuctionOrdersScreen(),
                      //       ),
                      //     );
                      //   },
                      // ),
                      SettingsItem(
                        title: AppStrings.delAcc.tr(),
                        trailing:  FaIcon(
                          Icons.delete_outline,
                          size: AppSize.settingsIconSize,
                        ),
                        onTap: () => _deleteAccount(context),
                      ),
                      SettingsItem(
                        title: "My Products".tr(),
                        trailing:  FaIcon(
                          Icons.list_alt,
                          size: AppSize.settingsIconSize,
                        ),
                        onTap: () => Navigator.pushNamed(
                            context, Routes.myProductsRoute),
                      ),
                    ] else
                      Container(),
                    SettingsItem(
                      title: AppStrings.contactUs.tr(),
                      trailing:  Icon(
                        Icons.contact_phone_outlined,
                        size: AppSize.settingsIconSize,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.contactUsRout);
                      },
                    ),
                    SettingsItem(
                      title: AppStrings.aboutUs.tr(),
                      trailing:  Icon(
                        Icons.info_outlined,
                        size: AppSize.settingsIconSize,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.aboutUsRout);
                      },
                    ),
                    SettingsItem(
                      onTap: () {
                      },
                      title:  AppStrings.qatariRiyal.tr(),
                      trailing: Icon(
                        FontAwesomeIcons.r,
                        size: AppSize.currencyIconSize,
                      ),
                    ),
                    // const CurrenciesMenu(),
                    const LanguageSwitcher(),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    isTokenExist
                        ? _logoutButton(context)
                        : _loginButton(context),
                  ],
                ),
              ),
            );
          } else {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(AppStrings.settings.tr()),
                  automaticallyImplyLeading: false,
                ),
                body: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    if (isTokenExist) ...[
                      SettingsItem(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.myProfileRoute);
                        },
                        title: AppStrings.myProf.tr(),
                        trailing:  Icon(
                          Icons.person,
                          size: AppSize.settingsIconSize,
                        ),
                      ),
                      SettingsItem(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.ordersRout);
                        },
                        title: AppStrings.myOrd.tr(),
                        trailing:  Icon(
                          Icons.shopping_cart_outlined,
                          size: AppSize.settingsIconSize,
                        ),
                      ),
                      //todo we will need this when activating auctions
                      // SettingsItem(
                      //   title: AppStrings.myAuctionOrd.tr(),
                      //   trailing: const ImageIcon(
                      //     AssetImage(ImageAssetsManager.auction),
                      //   ),
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => MyAuctionOrdersScreen(),
                      //       ),
                      //     );
                      //   },
                      // ),
                      SettingsItem(
                        title: AppStrings.delAcc.tr(),
                        trailing:  FaIcon(
                          Icons.delete_outline,
                          size: AppSize.settingsIconSize,
                        ),
                        onTap: () => _deleteAccount(context),
                      ),
                      SettingsItem(
                        title: "My Products".tr(),
                        trailing:  FaIcon(
                          Icons.list_alt,
                          size: AppSize.settingsIconSize,
                        ),
                        onTap: () => Navigator.pushNamed(
                            context, Routes.myProductsRoute),
                      ),
                    ] else
                      Container(),
                    SettingsItem(
                      title: AppStrings.contactUs.tr(),
                      trailing:   Icon(
                        Icons.contact_phone_outlined,
                        size: AppSize.settingsIconSize,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.contactUsRout);
                      },
                    ),
                    SettingsItem(
                      title: AppStrings.aboutUs.tr(),
                      trailing:  Icon(
                        Icons.info_outlined,
                        size: AppSize.settingsIconSize,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.aboutUsRout);
                      },
                    ),
                    SettingsItem(
                      onTap: () {
                      },
                      title:  AppStrings.qatariRiyal.tr(),
                      trailing: Icon(
                        FontAwesomeIcons.r,
                        size: AppSize.currencyIconSize,
                      ),
                    ),
                    // const CurrenciesMenu(),
                    const LanguageSwitcher(),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    isTokenExist
                        ? _logoutButton(context)
                        : _loginButton(context),
                    
                  ],
                ),
              ),
            );
          }
        });
  }

  _logoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        onPressed: () => _logout(context),
        child: Text(
          AppStrings.logout.tr(),
        ),
      ),
    );
  }

  _loginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, Routes.loginRoute),
        child: Text(
          AppStrings.login.tr(),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    AlertDialog logoutDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.w),
        ),
      ),
      backgroundColor: Colors.white,
      titleTextStyle: Theme.of(context).textTheme.subtitle2,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.areYouSureYouWantToLogout.tr(),
            textAlign: TextAlign.center,
          ),
          SizedBoxFunctions.verticalSizedBox(2),
          const Divider(
            height: 15,
            endIndent: 0,
            indent: 0.5,
            thickness: 1.6,
          ),
          SizedBoxFunctions.verticalSizedBox(2),
          BlocListener<LogoutCubit, LogoutState>(
            listener: (ctx, state) {
              if (state is LogoutSuccess) {
                Navigator.pop(context);
                context
                    .read<AppBottomNavigationBarIndexChangerCubit>()
                    .changeScreen(homeId);
                Fluttertoast.showToast(msg: state.message);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<LogoutCubit>().logout();
                  },
                  child: Text(
                    AppStrings.yes.tr(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.no.tr(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return logoutDialog;
      },
    );
  }

  void _deleteAccount(BuildContext context) {
    AlertDialog deleteAccountDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.w),
        ),
      ),
      backgroundColor: Colors.white,
      titleTextStyle: Theme.of(context).textTheme.subtitle2,
      content: SizedBox(
        height: 30.h,
        child: BlocConsumer<DeleteAccountCubit,
            PostingState<EmptySuccessResponseEntity>>(
          listener: (context, state) {
            state.whenOrNull(
              success: (entity) {
                Navigator.pop(context);
                context
                    .read<AppBottomNavigationBarIndexChangerCubit>()
                    .changeScreen(homeId);
                return Fluttertoast.showToast(
                    msg: entity.message, toastLength: Toast.LENGTH_SHORT);
              },
              error: (NetworkExceptions error) => Fluttertoast.showToast(
                  msg: NetworkExceptions.getErrorMessage(error),
                  toastLength: Toast.LENGTH_SHORT),
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => LoadingCircularWidget(),
              orElse: () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.areYouSureYouWantToDeletaAccount.tr(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBoxFunctions.verticalSizedBox(2),
                  const Divider(
                    height: 15,
                    endIndent: 0,
                    indent: 0.5,
                    thickness: 1.6,
                  ),
                  SizedBoxFunctions.verticalSizedBox(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<DeleteAccountCubit>()
                              .emitDeleteAccount();
                        },
                        child: Text(
                          AppStrings.yes.tr(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppStrings.no.tr(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return deleteAccountDialog;
      },
    );
  }
}
