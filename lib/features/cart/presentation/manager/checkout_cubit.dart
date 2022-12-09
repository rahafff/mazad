import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/bodies/checkout_body.dart';
import '../../domain/repositories/cart_repository.dart';

class CheckoutCubit extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  CheckoutCubit(this._cartRepository) : super(const PostingState.idle());
  final CartRepository _cartRepository;

  Future<void> emitCheckout(CheckOutBody body) async {
    emit(const PostingState.loading());
    var response = await _cartRepository.checkout(body);
    response.when(
      success: (success) {
        emit(
          PostingState.success(success),
        );
      },
      failure: (failure) => emit(
        PostingState.error(failure),
      ),
    );
  }
}
