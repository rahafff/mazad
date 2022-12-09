import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/user/domain/bodies/update_user_info_body.dart';
import 'package:elite_auction/features/user/domain/entities/user_entity.dart';

import '../../../../core/models/api_response.dart';
import '../bodies/login_body.dart';
import '../bodies/register_body.dart';
import '../bodies/update_password_body.dart';
import '../bodies/update_user_address_body.dart';

abstract class UserRepository {
  Future<ApiResponse<BaseEntity<UserEntity>>> login(LoginBody body);
  Future<ApiResponse<BaseEntity<UserEntity>>> register(RegisterBody body);
  Future<ApiResponse<EmptySuccessResponseEntity>> updateUserInfo(
      UpdateUserInfoBody body);
  Future<ApiResponse<EmptySuccessResponseEntity>> updateUserAddress(
      UpdateUserAddressBody body);
  Future<ApiResponse<EmptySuccessResponseEntity>> deleteAccount();
  Future<ApiResponse<bool>> verifyOtp(String? otp);
  Future<ApiResponse<bool>> sendCode(String? phoneNumber);
  Future<ApiResponse<EmptySuccessResponseEntity>> updatePassword(
      UpdatePasswordBody params);
}
