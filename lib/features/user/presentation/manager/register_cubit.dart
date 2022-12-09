import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/models/base_entity.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/global.dart';
import '../../domain/bodies/register_body.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class RegisterCubit extends Cubit<PostingState<BaseEntity<UserEntity>>> {
  RegisterBody registerParams = RegisterBody(
      password: '',
      phoneNumber: '',
      name: '',
      tokenId: '',
      userId: '',
      confirmPassword: '',
      fcmToken: '');
  final UserRepository _userRepository;
  RegisterCubit(this._userRepository) : super(const Idle());

  void emitRegister(RegisterBody params) async {
    emit(const PostingState.loading());
    var result = await _userRepository.register(params);
    result.when(success: (BaseEntity<UserEntity> userEntity) {
      AppSharedPreferences.accessPassword = params.password;
      AppSharedPreferences.accessPhone = params.phoneNumber;
      isTokenExist = true;
      emit(PostingState.success(userEntity));
    }, failure: (NetworkExceptions networkExceptions) {
      emit(PostingState.error(networkExceptions));
    });
  }

  void setRegisterParams({
    required String password,
    required String confirmPassword,
    required String name,
    required String phoneNumber,
  }) {
    registerParams.confirmPassword = confirmPassword;
    registerParams.name = name;
    registerParams.password = password;
    registerParams.phoneNumber = phoneNumber;
  }
}
