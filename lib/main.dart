import 'dart:io' show HttpClient, HttpOverrides, Platform, SecurityContext, X509Certificate;

import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/bloc_observer.dart';
import 'package:elite_auction/core/utils/app_path_provider.dart';
import 'package:elite_auction/core/utils/notification/notification_viewer.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_navigation_bar_badges_cubit.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_getter_cubit.dart';
import 'package:elite_auction/features/settings/presentation/manager/currency_cubit.dart';
import 'package:elite_auction/features/settings/presentation/manager/language_cubit.dart';
import 'package:elite_auction/features/splash/presentation/manager/application_version_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/login_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/register_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/update_password_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/update_user_info_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/verification_cubit.dart';
import 'package:elite_auction/features/wishlist/presentation/manager/wishlist_operations_cubit.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'core/constants.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/theme_manager.dart';
import 'core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'features/cart/presentation/manager/cart_operations_cubit.dart';
import 'features/cart/presentation/manager/checkout_cubit.dart';
import 'features/cart/presentation/manager/payment_cubit.dart';
import 'features/home/presentation/manager/product_variation_cubit.dart';
import 'features/notifications/presentation/manager/notification_cubit.dart';
import 'features/user/presentation/manager/delete_account_cubit.dart';
import 'features/user/presentation/manager/logout_cubit.dart';
import 'features/user/presentation/manager/update_user_address_cubit.dart';
import 'features/wishlist/presentation/manager/wishlist_getter_cubit.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}
class MyHttpOverrides extends HttpOverrides {
@override
HttpClient createHttpClient(SecurityContext? context) {
return super.createHttpClient(context)
  ..badCertificateCallback =
      (X509Certificate cert, String host, int port) => true; }}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    if (kDebugMode) print(match.group(0));
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  await AppPathProvider.initPath();
  await Firebase.initializeApp();
  NotificationViewer.initialize();
  HttpOverrides.global =  MyHttpOverrides();

  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  printFullText('%%%%%%%%%%%%%%%% ${AppSharedPreferences.accessToken}');
  await EasyLocalization.ensureInitialized();
  String defaultLocale = Platform.localeName;
  if (defaultLocale.substring(0, 2) == 'en') {
    defaultLocale = 'en';
  } else if (defaultLocale.substring(0, 2) == 'ar') {
    defaultLocale = 'ar';
  } else {
    defaultLocale = 'en';
  }

  Locale? startLocale;
  String? lang = AppSharedPreferences.lang;
  if (lang == null) {
    startLocale = LANGUAGES[defaultLocale];
    AppSharedPreferences.lang = defaultLocale;
  } else {
    startLocale = LANGUAGES[AppSharedPreferences.lang];
  }
  if (kDebugMode) {
    print(AppSharedPreferences.lang);
  }
  await di.init();
  BlocOverrides.runZoned(
    () => runApp(EasyLocalization(
      startLocale: startLocale,
      supportedLocales: LANGUAGES.values.toList(),
      path: "assets/language",
      child: const EliteAuction(),
    )),
    blocObserver: AppBlocObserver(),
  );
}

class EliteAuction extends StatefulWidget {
  const EliteAuction({Key? key}) : super(key: key);
  static final GlobalKey navigatorKey = GlobalKey();

  @override
  State<EliteAuction> createState() => _EliteAuctionState();
}

class _EliteAuctionState extends State<EliteAuction> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MultiBlocProvider(
          providers: [
            //todo determine global cubits
            BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),

            BlocProvider<UpdatePasswordCubit>(
                create: (_) => di.sl<UpdatePasswordCubit>()),
            BlocProvider<RegisterCubit>(create: (_) => di.sl<RegisterCubit>()),
            BlocProvider<VerificationCubit>(
                create: (_) => di.sl<VerificationCubit>()),
            BlocProvider<CurrencyCubit>(create: (_) => di.sl<CurrencyCubit>()),
            BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
            BlocProvider<AppBottomNavigationBarIndexChangerCubit>(
                create: (_) =>
                    di.sl<AppBottomNavigationBarIndexChangerCubit>()),
            BlocProvider<AppNavigationBarBadgesCubit>(
                create: (_) => di.sl<AppNavigationBarBadgesCubit>()),
            BlocProvider<CartOperationsCubit>(
                create: (_) => di.sl<CartOperationsCubit>()),

            BlocProvider<WishlistOperationsCubit>(
                create: (_) => di.sl<WishlistOperationsCubit>()),
            BlocProvider<CartGetterCubit>(
                create: (_) => di.sl<CartGetterCubit>()),
            BlocProvider<WishlistGetterCubit>(
                create: (_) => di.sl<WishlistGetterCubit>()),
            BlocProvider<LogoutCubit>(create: (_) => di.sl<LogoutCubit>()),
            BlocProvider<UpdateUserInfoCubit>(
                create: (_) => di.sl<UpdateUserInfoCubit>()),
            BlocProvider<UpdateUserAddressCubit>(
                create: (_) => di.sl<UpdateUserAddressCubit>()),
            BlocProvider<DeleteAccountCubit>(
                create: (_) => di.sl<DeleteAccountCubit>()),
            BlocProvider<ApplicationVersionCubit>(
                create: (_) => di.sl<ApplicationVersionCubit>()),
            BlocProvider<ProductVariationCubit>(
                create: (_) => di.sl<ProductVariationCubit>()),
            BlocProvider<CardPaymentCubit>(
                create: (_) => di.sl<CardPaymentCubit>()),

            BlocProvider<NotificationCubit>(
                create: (_) => di.sl<NotificationCubit>(), lazy: false),
            BlocProvider<CheckoutCubit>(create: (_) => di.sl<CheckoutCubit>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
           onGenerateRoute: RouteGenerator.getRoute,
           initialRoute: Routes.splash,
            title: "Alnokhba Auctions",
            theme: getApplicationTheme(),
            key: EliteAuction.navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        );
      },
    );
  }
}
