import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/core/utils/global.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../domain/bodies/login_body.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class LoginCubit extends Cubit<PostingState<BaseEntity<UserEntity>>> {
  final UserRepository _userRepository;

  LoginCubit(this._userRepository) : super(const Idle());

  void emitLogin(LoginBody params) async {
    emit(const PostingState.loading());
    var result = await _userRepository.login(params);
    result.when(success: (BaseEntity<UserEntity> loginEntity) {
      AppSharedPreferences.accessPassword = params.password;
      AppSharedPreferences.accessPhone = params.phoneNumber;
      isTokenExist = true;
      emit(PostingState.success(loginEntity));
    }, failure: (NetworkExceptions networkExceptions) {
      emit(PostingState.error(networkExceptions));
    });
  }
}
