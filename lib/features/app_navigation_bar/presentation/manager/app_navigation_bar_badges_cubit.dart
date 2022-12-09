import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/navigation_bar_repository.dart';

part 'app_navigation_bar_badges_state.dart';

class AppNavigationBarBadgesCubit extends Cubit<AppNavigationBarBadgesState> {
  final NavigationBarRepository _navigationBarRepository;

  AppNavigationBarBadgesCubit(
    this._navigationBarRepository,
  ) : super(AppNavigationBarBadgesState());

  Future<void> emitGetCartAndWishlistItemCount() async {
    var response = await _navigationBarRepository.getCartAndWishlistItemCount();
    response.when(
        success: (entity) {
          emit(
            state.copyWith(
                cartItemsCount: entity.data?.cartItemsCount,
                wishlistItemsCount: entity.data?.wishlistItemsCount),
          );
        },
        failure: (error) {}); // todo decide later what to do when error occur
  }

  void hideBadges() {
    emit(state.dispose());
  }
}
