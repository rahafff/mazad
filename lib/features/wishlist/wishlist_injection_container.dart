import 'package:elite_auction/features/wishlist/data/remote/data_sources/wishlist_remote_data_source.dart';
import 'package:elite_auction/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:elite_auction/features/wishlist/domain/repositories/wishlist_repository_imp.dart';
import 'package:elite_auction/features/wishlist/presentation/manager/wishlist_getter_cubit.dart';
import 'package:elite_auction/features/wishlist/presentation/manager/wishlist_operations_cubit.dart';

import '../../../injection_container.dart';

Future<void> initWishlist() async {
  //cubits
  sl.registerFactory<WishlistOperationsCubit>(() => WishlistOperationsCubit(
        sl(),
      ));
  sl.registerFactory<WishlistGetterCubit>(() => WishlistGetterCubit(sl()));

  // repository
  sl.registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImp(sl(), sl()));
  //local data sources

  //remote data sources
  sl.registerLazySingleton<WishlistRemoteDataSource>(
      () => WishlistRemoteDataSourceImp(sl()));
}
