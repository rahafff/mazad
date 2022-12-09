import '../../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';

abstract class FireBaseLocalDataSource {
  Future<void> saveFireBaseTokenId(String? tokenId);
  Future<void> saveFireBaseUserId(String? userId);
}

class FireBaseLocalDataSourceImp implements FireBaseLocalDataSource {
  @override
  Future<void> saveFireBaseTokenId(String? tokenId) async {
    if (tokenId != null) AppSharedPreferences.accessTokenFirebase = tokenId;
  }

  @override
  Future<void> saveFireBaseUserId(String? userId) async {
    if (userId != null) AppSharedPreferences.accessUuid = userId;
  }
}
