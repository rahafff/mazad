part of 'app_navigation_bar_badges_cubit.dart';

class AppNavigationBarBadgesState {
  final int? cartItemsCount;
  final int? wishlistItemsCount;
  AppNavigationBarBadgesState({this.cartItemsCount, this.wishlistItemsCount});

  AppNavigationBarBadgesState copyWith({
    int? cartItemsCount,
    int? wishlistItemsCount,
  }) {
    return AppNavigationBarBadgesState(
      cartItemsCount: cartItemsCount ?? this.cartItemsCount,
      wishlistItemsCount: wishlistItemsCount ?? this.wishlistItemsCount,
    );
  }

  AppNavigationBarBadgesState dispose() {
    return AppNavigationBarBadgesState(
      cartItemsCount: null,
      wishlistItemsCount: null,
    );
  }
}
