import 'package:elite_auction/features/splash/data/remote/data_sources/splash_remote_data_source.dart';
import 'package:elite_auction/features/splash/domain/entities/version_entity.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/models/api_response.dart';
import '../../../../core/models/base_entity.dart';
import '../../../../core/network/netwok_info.dart';
import 'splash_repository.dart';

class SplashRepositoryImp implements SplashRepository {
  final NetworkInfo _networkInfo;
  final SplashRemoteDataSource _splashRemoteDataSource;
  SplashRepositoryImp(this._networkInfo, this._splashRemoteDataSource);

  @override
  Future<ApiResponse<BaseEntity<VersionEntity>>> getApplicationVersion() async {
    return await _getBaseEntityResult(
      () => _splashRemoteDataSource.getApplicationVersion(),
    );
  }

  Future<ApiResponse<BaseEntity<T>>> _getBaseEntityResult<T>(
      Future<BaseEntity<T>> Function() getResult) async {
    try {
      if (await _networkInfo.isConnected) {
        var response = await getResult();
        return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
