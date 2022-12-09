import 'package:elite_auction/features/splash/data/remote/data_sources/splash_remote_data_source.dart';
import 'package:elite_auction/features/splash/domain/repositories/splash_repository.dart';
import 'package:elite_auction/features/splash/domain/repositories/splash_repository_imp.dart';
import 'package:elite_auction/features/splash/presentation/manager/application_version_cubit.dart';

import '../../../injection_container.dart';

Future<void> initSplash() async {
  //cubits
  sl.registerFactory<ApplicationVersionCubit>(
      () => ApplicationVersionCubit(sl(), sl()));

  // repository
  sl.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImp(sl(), sl()));
  //local data sources

  //remote data sources
  sl.registerLazySingleton<SplashRemoteDataSource>(
      () => SplashRemoteDataSourceImp(sl()));
}
