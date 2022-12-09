import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/cart/domain/bodies/add_to_cart_body.dart';
import 'package:elite_auction/features/cart/domain/bodies/delete_from_cart_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/cart_repository.dart';

class CartOperationsCubit
    extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  final CartRepository _cartRepository;

  CartOperationsCubit(
    this._cartRepository,
  ) : super(const PostingState.idle());
  Future<void> emitAddToCart(AddToCartBody body) async {
    emit(const PostingState.loading());
    var response = await _cartRepository.addToCart(body);
    response.when(
      success: (success) => emit(
        PostingState.success(success),
      ),
      failure: (failure) => emit(
        PostingState.error(failure),
      ),
    );
  }

  Future<void> emitDeleteFromCart(DeleteFromCartBody body) async {
    emit(const PostingState.loading());
    var response = await _cartRepository.deleteFromCart(body);
    response.when(
      success: (success) => emit(
        PostingState.success(success),
      ),
      failure: (failure) => emit(
        PostingState.error(failure),
      ),
    );
  }
}
