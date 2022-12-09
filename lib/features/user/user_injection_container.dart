import 'package:elite_auction/features/user/data/data_sources/local_data_source/firebase_local_data_source.dart';
import 'package:elite_auction/features/user/data/data_sources/local_data_source/user_local_data_source.dart';
import 'package:elite_auction/features/user/data/data_sources/remote_data_source/firebase_remote_data_source.dart';
import 'package:elite_auction/features/user/data/data_sources/remote_data_source/user_remote_data_source.dart';
import 'package:elite_auction/features/user/domain/repositories/user_repository.dart';
import 'package:elite_auction/features/user/domain/repositories/user_repository_imp.dart';
import 'package:elite_auction/features/user/presentation/manager/delete_account_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/login_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/logout_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/register_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/update_password_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/update_user_address_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/update_user_info_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/verification_cubit.dart';

import '../../injection_container.dart';

Future<void> initUser() async {
  //cubits
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl()));
  sl.registerFactory<LogoutCubit>(() => LogoutCubit());
  sl.registerFactory<UpdatePasswordCubit>(() => UpdatePasswordCubit(sl()));
  sl.registerFactory<DeleteAccountCubit>(() => DeleteAccountCubit(sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(sl()));
  sl.registerFactory<VerificationCubit>(() => VerificationCubit(
        sl(),
      ));
  sl.registerFactory<UpdateUserInfoCubit>(() => UpdateUserInfoCubit(sl()));
  sl.registerFactory<UpdateUserAddressCubit>(
      () => UpdateUserAddressCubit(sl()));
  //repositories
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImp(sl(), sl(), sl(), sl(), sl()));

  //local data sources
  sl.registerLazySingleton<FireBaseLocalDataSource>(
      () => FireBaseLocalDataSourceImp());
  sl.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImp());
  //remote data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImp(sl()));
  sl.registerLazySingleton<FireBaseRemoteDataSource>(
      () => FireBaseRemoteDataSourceImp(sl()));
}
