import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/features/splash/domain/entities/version_entity.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/models/base_entity.dart';

abstract class SplashRemoteDataSource {
  Future<BaseEntity<VersionEntity>> getApplicationVersion();
}

class SplashRemoteDataSourceImp implements SplashRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SplashRemoteDataSourceImp(this._apiConsumer);

  @override
  Future<BaseEntity<VersionEntity>> getApplicationVersion() async {
    return await _getBaseEntityResult(
      apiCall: () => _apiConsumer.get(
        EndPoints.getApplicationVersion,
      ),
      fromJson: (json) => VersionEntity.fromJson(json),
    );
  }

  Future<BaseEntity<T>> _getBaseEntityResult<T>(
      {required Future<dynamic> Function() apiCall,
      required T Function(dynamic json) fromJson}) async {
    var response = await apiCall();
    return BaseEntity.fromJson(response, (json) => fromJson(json));
  }
}
