import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/firebase_dynamic_link_service.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_navigation_bar_badges_cubit.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_operations_cubit.dart';
import 'package:elite_auction/features/user/domain/entities/user_entity.dart';
import 'package:elite_auction/features/user/presentation/manager/login_cubit.dart';
import 'package:elite_auction/features/wishlist/presentation/manager/wishlist_operations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/global.dart';
import '../../../user/presentation/manager/logout_cubit.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    if (isTokenExist) {
      context
          .read<AppNavigationBarBadgesCubit>()
          .emitGetCartAndWishlistItemCount();
    }
    FirebaseDynamicLinkService.initDynamicLink(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navBarIndexChangerContext =
        context.read<AppBottomNavigationBarIndexChangerCubit>();
    final navBarBadgesContext = context.read<AppNavigationBarBadgesCubit>();

    return WillPopScope(
      onWillPop: () async {
        final differance = DateTime.now().difference(timeBackPressed);
        final isExitWarning = differance >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          Fluttertoast.showToast(msg: AppStrings.pressBackAgainToExit.tr());
          return false;
        } else {
          return exit(0);
        }
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<CartOperationsCubit,
              PostingState<EmptySuccessResponseEntity>>(
            listener: (context, state) {
              state.whenOrNull(
                success: (_) =>
                    navBarBadgesContext.emitGetCartAndWishlistItemCount(),
              );
            },
          ),
          BlocListener<WishlistOperationsCubit,
              PostingState<EmptySuccessResponseEntity>>(
            listener: (context, state) {
              state.whenOrNull(
                success: (_) =>
                    navBarBadgesContext.emitGetCartAndWishlistItemCount(),
              );
            },
          ),
          BlocListener<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                navBarBadgesContext.hideBadges();
              }
            },
          ),
          BlocListener<LoginCubit, PostingState<BaseEntity<UserEntity>>>(
            listener: (context, state) {
              state.whenOrNull(
                success: (_) =>
                    navBarBadgesContext.emitGetCartAndWishlistItemCount(),
              );
            },
          ),
        ],
        child: BlocBuilder<AppBottomNavigationBarIndexChangerCubit,
            AppBottomNavigationBarIndexChangerState>(
          builder: (context, state) {
            return Scaffold(
              body: navBarIndexChangerContext.screens[state.screenIndex],
              bottomNavigationBar: Container(
                margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(7.0.w),
                        topLeft: Radius.circular(7.0.w)),
                    child: BottomNavigationBar(
                      items: navBarIndexChangerContext.bottomNavBarItems,
                      onTap: (index) {
                        navBarIndexChangerContext.changeScreen(index);
                      },
                      currentIndex: state.screenIndex,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
