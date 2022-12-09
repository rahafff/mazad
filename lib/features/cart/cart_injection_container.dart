import 'package:elite_auction/features/cart/data/remote/data_sources/cart_remote_data_source.dart';
import 'package:elite_auction/features/cart/domain/repositories/cart_repository.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_getter_cubit.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_operations_cubit.dart';
import 'package:elite_auction/features/cart/presentation/manager/checkout_cubit.dart';
import 'package:elite_auction/features/cart/presentation/manager/location_cubit.dart';
import 'package:elite_auction/features/cart/presentation/manager/payment_cubit.dart';

import '../../../injection_container.dart';
import 'domain/repositories/cart_repository_imp.dart';

Future<void> initCart() async {
  //cubits
  sl.registerFactory<CartOperationsCubit>(() => CartOperationsCubit(
        sl(),
      ));
  sl.registerFactory<CartGetterCubit>(() => CartGetterCubit(sl()));
  sl.registerLazySingleton<CardPaymentCubit>(() => CardPaymentCubit(
        sl(),
      ));
  sl.registerFactory<CheckoutCubit>(() => CheckoutCubit(sl()));
  sl.registerFactory<LocationCubit>(() => LocationCubit(sl()));



  // repository
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImp(sl(), sl()));
  //local data sources

  //remote data sources
  sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImp(sl()));
}
