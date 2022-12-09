import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../../domain/bodies/update_password_body.dart';
import '../../domain/repositories/user_repository.dart';

class UpdatePasswordCubit
    extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  final UserRepository _userRepository;

  UpdatePasswordCubit(this._userRepository) : super(const Idle());

  void emitUpdatePassword(UpdatePasswordBody params) async {
    emit(const PostingState.loading());
    var result = await _userRepository.updatePassword(params);
    result.when(success: (entity) {
      AppSharedPreferences.accessPassword = params.newPassword;
      emit(PostingState.success(entity));
    }, failure: (NetworkExceptions networkExceptions) {
      emit(PostingState.error(networkExceptions));
    });
  }
}
