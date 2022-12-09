import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:elite_auction/core/api/logging_interceptor.dart';
import 'package:elite_auction/features/cart/cart_injection_container.dart';
import 'package:elite_auction/features/user/user_injection_container.dart';
import 'package:elite_auction/features/wishlist/wishlist_injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/netwok_info.dart';
import 'core/utils/app_path_provider.dart';
import 'features/app_navigation_bar/navigation_bar_injection_container.dart';
import 'features/home/home_injection_container.dart';
import 'features/notifications/presentation/manager/notification_cubit.dart';
import 'features/settings/settings_injection_container.dart';
import 'features/splash/splash_injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<NotificationCubit>(() => NotificationCubit(
        sl(),
      ));

  /// Features
  //Auth
  initUser();
  //Home
  initHome();
  //Settings
  initSettings();
  //Cart
  initCart();
  //Wishlist
  initWishlist();
  //navBar
  initNavBar();
  //splash
  initSplash();

  /// Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  /// External
  final sharedPreference = await SharedPreferences.getInstance();
  final firebaseMessaging = FirebaseMessaging.instance;
  final localNotifications = FlutterLocalNotificationsPlugin();
  final packageInfo = await PackageInfo.fromPlatform();
  final firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => sharedPreference);
  sl.registerLazySingleton(() => localNotifications);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseMessaging);

  sl.registerLazySingleton(() => packageInfo);
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(
    () => DioCacheInterceptor(
      options: CacheOptions(
        store: HiveCacheStore(AppPathProvider.path),
        policy: CachePolicy.refreshForceCache,
        hitCacheOnErrorExcept: [],

        maxStale: const Duration(
          hours: 1,
        ), //increase number of days for loger cache
        priority: CachePriority.low,
      ),
    ),
  );
}
