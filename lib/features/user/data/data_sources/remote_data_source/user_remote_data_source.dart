import 'package:elite_auction/core/api/api_consumer.dart';
import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/user/domain/bodies/update_user_info_body.dart';
import 'package:elite_auction/features/user/domain/entities/user_entity.dart';

import '../../../domain/bodies/login_body.dart';
import '../../../domain/bodies/register_body.dart';
import '../../../domain/bodies/update_password_body.dart';
import '../../../domain/bodies/update_user_address_body.dart';

abstract class UserRemoteDataSource {
  Future<BaseEntity<UserEntity>> login(LoginBody body);
  Future<EmptySuccessResponseEntity> updateUserInfo(UpdateUserInfoBody body);
  Future<EmptySuccessResponseEntity> deleteAccount();
  Future<EmptySuccessResponseEntity> updateUserAddress(
      UpdateUserAddressBody body);
  Future<BaseEntity<UserEntity>> register(RegisterBody body);
  Future<EmptySuccessResponseEntity> updatePassword(UpdatePasswordBody body);
}

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  final ApiConsumer _apiConsumer;

  UserRemoteDataSourceImp(this._apiConsumer);
  @override
  @override
  Future<BaseEntity<UserEntity>> login(LoginBody body) async {
    return await _getBaseEntityResult(
      apiCall: () => _apiConsumer.post(
        EndPoints.login,
        body: body.toJson(),
      ),
      fromJson: (json) => UserEntity.fromJson(json),
    );
  }

  @override
  Future<EmptySuccessResponseEntity> updatePassword(
      UpdatePasswordBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.updatePassword,
        body: body.toJson(),
      ),
    );
  }

  @override
  Future<EmptySuccessResponseEntity> updateUserInfo(
      UpdateUserInfoBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.updateUserInfo,
        body: body.toJson(),
      ),
    );
  }

  @override
  Future<EmptySuccessResponseEntity> updateUserAddress(
      UpdateUserAddressBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.updateUserAddress,
        body: body.toJson(),
      ),
    );
  }

  @override
  Future<EmptySuccessResponseEntity> deleteAccount() async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.deleteAccount,
      ),
    );
  }

  @override
  Future<BaseEntity<UserEntity>> register(RegisterBody body) async {
    return await _getBaseEntityResult(
      apiCall: () => _apiConsumer.post(
        EndPoints.register,
        body: body.toJson(),
      ),
      fromJson: (json) => UserEntity.fromJson(json),
    );
  }

  Future<BaseEntity<T>> _getBaseEntityResult<T>(
      {required Future<dynamic> Function() apiCall,
      required T Function(dynamic json) fromJson}) async {
    var response = await apiCall();
    return BaseEntity.fromJson(response, (json) => fromJson(json));
  }

  Future<EmptySuccessResponseEntity> _getEmptySuccessResponseResult<T>(
      Future<dynamic> Function() apiCall) async {
    var response = await apiCall();
    return EmptySuccessResponseEntity.fromJson(response);
  }
}
