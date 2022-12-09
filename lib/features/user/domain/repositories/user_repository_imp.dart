import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/user/domain/bodies/update_user_address_body.dart';
import 'package:elite_auction/features/user/domain/bodies/update_user_info_body.dart';
import 'package:elite_auction/features/user/domain/entities/user_entity.dart';
import 'package:elite_auction/features/user/domain/repositories/user_repository.dart';

import '../../../../core/models/api_response.dart';
import '../../../../core/network/netwok_info.dart';
import '../../data/data_sources/local_data_source/firebase_local_data_source.dart';
import '../../data/data_sources/local_data_source/user_local_data_source.dart';
import '../../data/data_sources/remote_data_source/firebase_remote_data_source.dart';
import '../../data/data_sources/remote_data_source/user_remote_data_source.dart';
import '../bodies/login_body.dart';
import '../bodies/register_body.dart';
import '../bodies/update_password_body.dart';

//todo to be refactored
class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;
  final FireBaseRemoteDataSource _fireBaseRemoteDataSource;
  final FireBaseLocalDataSource _fireBaseLocalDataSource;
  final NetworkInfo _networkInfo;

  UserRepositoryImp(
      this._userRemoteDataSource,
      this._userLocalDataSource,
      this._networkInfo,
      this._fireBaseRemoteDataSource,
      this._fireBaseLocalDataSource);

  @override
  Future<ApiResponse<BaseEntity<UserEntity>>> login(LoginBody body) async {
    try {
      if (await _networkInfo.isConnected) {
        var response = await _userRemoteDataSource.login(body);
        await _userLocalDataSource.saveLoggedInUser(response.data);
        return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  @override
  Future<ApiResponse<BaseEntity<UserEntity>>> register(
      RegisterBody body) async {
    try {
      if (await _networkInfo.isConnected) {
        var response = await _userRemoteDataSource.register(body);
        await _userLocalDataSource.saveRegisteredUser(response.data);
        return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  @override
  Future<ApiResponse<bool>> sendCode(String? phoneNumber) async {
    try {
      if (await _networkInfo.isConnected) {
        Map<String, String?> uuIdAndToken =
            await _fireBaseRemoteDataSource.sendCode(phoneNumber);
        _fireBaseLocalDataSource
          ..saveFireBaseTokenId(uuIdAndToken['idToken'])
          ..saveFireBaseUserId(uuIdAndToken['userId']);
        return const ApiResponse.success(true);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

  @override
  Future<ApiResponse<bool>> verifyOtp(String? otp) async {
    try {
      if (await _networkInfo.isConnected) {
        Map<String, String?> uuIdAndToken =
            await _fireBaseRemoteDataSource.verify(otp);
        _fireBaseLocalDataSource
          ..saveFireBaseTokenId(uuIdAndToken['idToken'])
          ..saveFireBaseUserId(uuIdAndToken['userId']);
        return const ApiResponse.success(true);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> updatePassword(
      UpdatePasswordBody body) async {
    try {
      if (await _networkInfo.isConnected) {
        var response = await _userRemoteDataSource.updatePassword(body);
        return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> updateUserAddress(
      UpdateUserAddressBody body) async {
    try {
      if (await _networkInfo.isConnected) {
        var response = await _userRemoteDataSource.updateUserAddress(body);
        return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> updateUserInfo(
      UpdateUserInfoBody body) async {
    try {
      if (await _networkInfo.isConnected) {
        var response = await _userRemoteDataSource.updateUserInfo(body);
        return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> deleteAccount() async {
    try {
      if (await _networkInfo.isConnected) {
        var response = await _userRemoteDataSource.deleteAccount();
        await _userLocalDataSource.deleteAccount();
        return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
}
