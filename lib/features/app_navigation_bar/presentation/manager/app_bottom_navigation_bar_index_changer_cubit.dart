import 'package:badges/badges.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/features/auctions/presentation/widgets/auction_coming_soon.dart';
import 'package:elite_auction/features/cart/presentation/pages/cart_screen.dart';
import 'package:elite_auction/features/home/presentation/pages/home_screen.dart';
import 'package:elite_auction/features/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../settings/presentation/pages/settings_screen.dart';
import 'app_navigation_bar_badges_cubit.dart';

part 'app_bottom_navigation_bar_index_changer_state.dart';

class AppBottomNavigationBarIndexChangerCubit
    extends Cubit<AppBottomNavigationBarIndexChangerState> {
  AppBottomNavigationBarIndexChangerCubit()
      : super( const AppBottomNavigationBarIndexChangerState(screenIndex: 0), ){ initBottomNavBar(); }

  late List<BottomNavigationBarItem> bottomNavBarItems = [];


  void initBottomNavBar(){
    bottomNavBarItems.add(
      BottomNavigationBarItem(
        activeIcon: buildNavBarIcon(assetName:ImageAssetsManager.clickedHome,width:  7.0.w,color: ColorManager.kGreen ),
        icon: buildNavBarIcon(assetName:  ImageAssetsManager.clickedHome,width: 5.0.w,color: ColorManager.kMove),
        label: AppStrings.home.tr(),
      ),);
    bottomNavBarItems.add(BottomNavigationBarItem(
      activeIcon: buildNavBarIcon(assetName:ImageAssetsManager.clickedAuction,width:  7.0.w,color: ColorManager.kGreen ),
      icon: buildNavBarIcon(assetName:  ImageAssetsManager.clickedAuction,width: 5.0.w,color: ColorManager.kMove),
          label: AppStrings.auctions.tr(),
        ),);
    bottomNavBarItems.add(BottomNavigationBarItem(
          activeIcon:
          buildCartIcon(color:ColorManager.kGreen,width: 7.0.w ),
          icon: buildCartIcon(color:ColorManager.kMove,width: 5.0.w),
          label: AppStrings.cart.tr(),
        ),);
    bottomNavBarItems.add(BottomNavigationBarItem(
      activeIcon:
      buildWishlistIcon(color:ColorManager.kGreen,width: 7.0.w ),
      icon: buildWishlistIcon(color:ColorManager.kMove,width: 5.0.w),
          label: AppStrings.wishlist.tr(),
        ),);
    bottomNavBarItems.add(BottomNavigationBarItem(
      activeIcon: buildNavBarIcon(assetName:ImageAssetsManager.clickedSettings,width:  7.0.w,color: ColorManager.kGreen ),
      icon: buildNavBarIcon(assetName:  ImageAssetsManager.clickedSettings,width: 5.0.w,color: ColorManager.kMove),
          label: AppStrings.settings.tr(),
        ));

  }

  Widget buildNavBarIcon({required String assetName,required double width, required Color color}){
    return SvgPicture.asset(
      assetName,
      width: width,
      color: color,
    );
  }

  Widget buildCartIcon({required Color color,required double width}){
    return  BlocBuilder<AppNavigationBarBadgesCubit, AppNavigationBarBadgesState>(
        buildWhen: (previous, current) =>
        previous.cartItemsCount != current.cartItemsCount,
        builder: (BuildContext context, state) {
          final cartCount = state.cartItemsCount;
          return Badge(
            showBadge:
            (cartCount != null && cartCount != 0) ? true : false,
            badgeContent: Text(
              cartCount.toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: ColorManager.kWhite),
            ),
            child: SvgPicture.asset(
              ImageAssetsManager.clickedCart,
              width: width,
              color: color ,
            ),
          );
        });

  }

  Widget buildWishlistIcon({required Color color,required double width,}){
    return BlocBuilder<AppNavigationBarBadgesCubit, AppNavigationBarBadgesState>(
        buildWhen: (previous, current) =>
        previous.wishlistItemsCount != current.wishlistItemsCount,
        builder: (BuildContext context, state) {
          final wishlistItemsCount = state.wishlistItemsCount;
          return Badge(
            showBadge:
            (wishlistItemsCount != null && wishlistItemsCount != 0) ? true : false,
            badgeContent: Text(
              wishlistItemsCount.toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: ColorManager.kWhite),
            ),
            child: SvgPicture.asset(
              ImageAssetsManager.clickedWishList,
              width:width,
              color: color,
            ),
          );
        });

  }


  List<Widget> screens = [
    const HomeScreen(),
    const AuctionComingSoon(),
    const CartScreen(),
    const WishlistScreen(),
    const SettingsScreen(),
  ];

  void changeScreen(int index) {
    emit(
      state.copyWith(screenIndex: index),
    );
  }
}
