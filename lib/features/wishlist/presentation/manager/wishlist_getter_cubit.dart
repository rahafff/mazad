import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/wishlist_repository.dart';

class WishlistGetterCubit extends Cubit<StandardState<Wishlist>> {
  final WishlistRepository _wishlistRepository;
  Map<int, WishlistItem> wishlistItems = {};
  int callingTimes = 1;
  WishlistGetterCubit(this._wishlistRepository)
      : super(const StandardState.loading());
  Future<void> emitGetDetailedWishlist() async {
    emit(const StandardState.loading());
    var response = await _wishlistRepository.getDetailedWishlist();
    response.when(
      success: (success) {
        callingTimes++;
        assignWishlistItemsMap(success);
        emit(
          StandardState.success(success.data!.wishlist),
        );
      },
      failure: (failure) => emit(
        StandardState.error(failure),
      ),
    );
  }

  void assignWishlistItemsMap(BaseEntity<WishlistEntity> success) {
    success.data!.wishlist.wishlistItems?.forEach(
      (element) {
        wishlistItems[element.id] = element;
      },
    );
  }

  bool isWishlistItem(int productId) {
    try {
      return wishlistItems[productId] != null;
    } catch (_) {
      return false;
    }
  }
}
