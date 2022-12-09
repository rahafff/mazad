import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/splash/domain/entities/version_entity.dart';

import '../../../../core/models/api_response.dart';

abstract class SplashRepository {
  Future<ApiResponse<BaseEntity<VersionEntity>>> getApplicationVersion();
}
