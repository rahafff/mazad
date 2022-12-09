import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/utils/global.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../domain/repositories/user_repository.dart';

class DeleteAccountCubit
    extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  final UserRepository _userRepository;

  DeleteAccountCubit(this._userRepository) : super(const Idle());

  void emitDeleteAccount() async {
    emit(const PostingState.loading());
    var result = await _userRepository.deleteAccount();
    result.when(success: (entity) {
      isTokenExist = false;
      emit(PostingState.success(entity));
    }, failure: (NetworkExceptions networkExceptions) {
      emit(PostingState.error(networkExceptions));
    });
  }
}
