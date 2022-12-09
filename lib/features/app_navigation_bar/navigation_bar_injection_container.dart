import 'package:elite_auction/features/app_navigation_bar/data/data_sources/remote_data_source/navigation_bar_remote_data_source.dart';
import 'package:elite_auction/features/app_navigation_bar/domain/repositories/navigation_bar_repository.dart';
import 'package:elite_auction/features/app_navigation_bar/domain/repositories/navigation_bar_repository_imp.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_navigation_bar_badges_cubit.dart';

import '../../../injection_container.dart';

Future<void> initNavBar() async {
  //cubits
  sl.registerFactory<AppNavigationBarBadgesCubit>(
      () => AppNavigationBarBadgesCubit(sl()));
  sl.registerFactory<AppBottomNavigationBarIndexChangerCubit>(
      () => AppBottomNavigationBarIndexChangerCubit());
  // repository
  sl.registerLazySingleton<NavigationBarRepository>(
      () => NavigationBarRepositoryImp(sl(), sl()));
  //local data sources

  //remote data sources
  sl.registerLazySingleton<NavigationBarRemoteDataSource>(
      () => NavigationBarRemoteDataSourceImp(sl()));
}
