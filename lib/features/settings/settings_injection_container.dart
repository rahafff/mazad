import 'dart:async';

import 'package:elite_auction/features/settings/data/remote/data_sources/settings_remote_data_source.dart';
import 'package:elite_auction/features/settings/domain/repositories/settings_repository.dart';
import 'package:elite_auction/features/settings/domain/repositories/settings_repository_impl.dart';
import 'package:elite_auction/features/settings/presentation/manager/about_us_cubit.dart';
import 'package:elite_auction/features/settings/presentation/manager/contact_us_cubit.dart';
import 'package:elite_auction/features/settings/presentation/manager/currency_cubit.dart';
import 'package:elite_auction/features/settings/presentation/manager/customer_products_paginator_cubit%20.dart';
import 'package:elite_auction/features/settings/presentation/manager/my_product_details_cubit.dart';
import 'package:elite_auction/features/settings/presentation/manager/order_details_cubit.dart';
import 'package:elite_auction/features/settings/presentation/manager/orders_paginator_cubit.dart';

import '../../../injection_container.dart';

Future<void> initSettings() async {
  //cubits
  sl.registerFactory<CurrencyCubit>(() => CurrencyCubit(sl()));
  sl.registerFactory<OrderPaginatorCubit>(() => OrderPaginatorCubit(sl()));
  sl.registerFactory<AboutUsCubit>(() => AboutUsCubit(sl()));
  sl.registerFactory<ContactUsCubit>(() => ContactUsCubit(sl()));
  sl.registerFactory<OrderDetailsCubit>(() => OrderDetailsCubit(sl()));
  sl.registerFactory<MyProductDetailsCubit>(() => MyProductDetailsCubit(sl(),));


  sl.registerFactory<CustomerProductsPaginatorCubit>(() => CustomerProductsPaginatorCubit(sl()));

  // repository
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImp(sl(), sl()));
  //local data sources

  //remote data sources
  sl.registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImp(sl()));
}
