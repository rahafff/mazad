import 'package:bloc/bloc.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/user/domain/bodies/update_user_address_body.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../domain/repositories/user_repository.dart';

class UpdateUserAddressCubit
    extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  final UserRepository _userRepository;

  UpdateUserAddressCubit(this._userRepository) : super(const Idle());

  void emitUpdateUserAddress(UpdateUserAddressBody body) async {
    emit(const PostingState.loading());
    var result = await _userRepository.updateUserAddress(body);
    result.when(success: (entity) {
      emit(PostingState.success(entity));
    }, failure: (NetworkExceptions networkExceptions) {
      emit(PostingState.error(networkExceptions));
    });
  }
}
