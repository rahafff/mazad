import 'package:elite_auction/features/home/domain/repositories/home_repository.dart';
import 'package:elite_auction/features/home/domain/repositories/home_repository_imp.dart';
import 'package:elite_auction/features/home/presentation/manager/advertisement_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/categories_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/customers_products_paginator_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/product_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/product_operations_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/product_variation_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/products_paginator_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/review_getter_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/review_operations_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/shops_categories_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/shops_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/slided_products_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/subcategories_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/subsubcategories_cubit.dart';

import '../../../injection_container.dart';
import 'data/remote/data_sources/home_remote_data_source.dart';

Future<void> initHome() async {
  //cubits
  sl.registerFactory<ShopsCubit>(() => ShopsCubit(sl()));
  sl.registerFactory<ProductVariationCubit>(() => ProductVariationCubit());
  sl.registerFactory<ProductsPaginatorCubit>(() => ProductsPaginatorCubit(
        sl(),
      ));
  sl.registerFactory<ShopCategoriesCubit>(() => ShopCategoriesCubit(sl()));
  sl.registerFactory<SubcategoriesCubit>(() => SubcategoriesCubit(sl()));
  sl.registerFactory<ProductCubit>(() => ProductCubit(sl()));
  sl.registerFactory<CategoriesCubit>(() => CategoriesCubit(sl()));
  sl.registerFactory<ReviewOperationsCubit>(() => ReviewOperationsCubit(sl()));
  sl.registerFactory<ProductOperationsCubit>(
      () => ProductOperationsCubit(sl()));
  sl.registerFactory<ReviewGetterCubit>(() => ReviewGetterCubit(sl()));
  sl.registerFactory<AdvertisementsCubit>(() => AdvertisementsCubit(sl()));
  sl.registerFactory<SlidedProductsCubit>(() => SlidedProductsCubit(sl()));
  sl.registerFactory<SubsubcategoriesCubit>(() => SubsubcategoriesCubit(sl()));
  sl.registerFactory<AllCustomersProductsCubit>(() => AllCustomersProductsCubit(sl()));

  //repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImp(sl(), sl()));

  //local data sources

  //remote data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImp(sl()));
}
