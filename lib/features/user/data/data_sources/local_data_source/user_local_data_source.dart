import 'package:elite_auction/features/user/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';

abstract class UserLocalDataSource {
  Future<void> saveLoggedInUser(UserEntity? loginEntity);
  Future<void> saveRegisteredUser(UserEntity? userEntity);
  Future<void> deleteAccount();
}

class UserLocalDataSourceImp implements UserLocalDataSource {
  UserLocalDataSourceImp();
  @override
  Future<void> saveLoggedInUser(UserEntity? userEntity) async {
    void printFullText(String text){
      final pattern=RegExp('.{1,800}');
      pattern.allMatches(text).forEach((match) {if (kDebugMode)  print(match.group(0)); } );
    }
    AppSharedPreferences.accessVerification =
        userEntity?.user?.isVerified.toString();
    AppSharedPreferences.accessPhone = userEntity?.user?.phone;
    AppSharedPreferences.accessName = userEntity?.user?.fullName;
    AppSharedPreferences.accessToken = userEntity?.token;
    // if (kDebugMode) {
      printFullText('****************  ${AppSharedPreferences.accessToken}');
    // }
    AppSharedPreferences.accessUserId = userEntity?.user?.id;
  }

  @override
  Future<void> saveRegisteredUser(UserEntity? userEntity) async {
    AppSharedPreferences.accessPhone = userEntity?.user?.phone;
    AppSharedPreferences.accessName = userEntity?.user?.fullName;
    AppSharedPreferences.accessToken = userEntity?.token;
    AppSharedPreferences.accessUserId = userEntity?.user?.id;
  }

  @override
  Future<void> deleteAccount() async {
    AppSharedPreferences.clear();
  }
}
