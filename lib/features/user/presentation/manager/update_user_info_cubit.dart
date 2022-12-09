import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/user/domain/bodies/update_user_info_body.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../domain/repositories/user_repository.dart';

class UpdateUserInfoCubit
    extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  final UserRepository _userRepository;

  UpdateUserInfoCubit(this._userRepository) : super(const Idle());

  void emitUpdateUserInfo(UpdateUserInfoBody body) async {
    emit(const PostingState.loading());
    var result = await _userRepository.updateUserInfo(body);
    result.when(success: (entity) {
      emit(PostingState.success(entity));
    }, failure: (NetworkExceptions networkExceptions) {
      emit(PostingState.error(networkExceptions));
    });
  }
}
