import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/add_to_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/delete_from_wishlist_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/wishlist_repository.dart';

class WishlistOperationsCubit
    extends Cubit<PostingState<EmptySuccessResponseEntity>> {
  final WishlistRepository _wishlistRepository;
  WishlistOperationsCubit(this._wishlistRepository)
      : super(const PostingState.idle());
  Future<void> emitAddToWishlist(AddToWishlistBody body) async {
    emit(const PostingState.loading());
    var response = await _wishlistRepository.addToWishlist(body);
    response.when(
      success: (success) => emit(
        PostingState.success(success),
      ),
      failure: (failure) => emit(
        PostingState.error(failure),
      ),
    );
  }

  Future<void> emitDeleteFromWishlist(DeleteFromWishlistBody body) async {
    emit(const PostingState.loading());
    var response = await _wishlistRepository.deleteFromWishlist(body);
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
