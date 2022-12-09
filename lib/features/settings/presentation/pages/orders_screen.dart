import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/shimmer/shimmer_order_list_view.dart';
import 'package:elite_auction/features/settings/presentation/manager/orders_paginator_cubit.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/global_states/pagination_state.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/utils/global.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/custom_pagination_widget.dart';
import '../../../../core/widgets/no_items_image.dart';
import '../../domain/entities/order_entity.dart';
import '../widgets/orders_list_view.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderPaginatorCubit>(
      create: (_) => di.sl<OrderPaginatorCubit>()..emitGetOrders(),
      child: Builder(builder: (context) {
        final orderContext = context.read<OrderPaginatorCubit>();
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(AppStrings.myOrd.tr()),
              leading: const BackButtonWidget(),
            ),
            body: BlocConsumer<OrderPaginatorCubit,
                PaginationState<PaginatedOrderEntity?>>(
              listener: (context, state) {
                state.whenOrNull(
                    error: (NetworkExceptions exception) =>
                        Fluttertoast.showToast(
                            msg: NetworkExceptions.getErrorMessage(exception),
                            toastLength: Toast.LENGTH_SHORT),
                    success: (entity, currentPage) {
                      _refreshController.refreshCompleted();
                      if (currentPage == orderContext.lastPage) {
                        _refreshController.loadNoData();
                      } else {
                        _refreshController.loadComplete();
                      }
                    });
              },
              builder: (context, state) {
                return state.when(
                  loading: () => const ShimmerOrdersListView(),
                  success: (entity, _) {
                    if (entity.isEmpty) {
                      return const NoItemsWidget();
                    } else {
                      return CustomPaginationWidget(
                        enablePullUp: true,
                        endOfScrollingMessage: AppStrings.noMoreOrders,
                        itemCount: entity.length,
                        listTobePaginated: OrdersListView(orders: entity),
                        refreshController: _refreshController,
                        onLoading: () =>
                            orderContext.emitGetOrders(loadMore: true),
                        onRefresh: () => orderContext.emitGetOrders(),
                        scrollController: _scrollController,
                        enablePullDown: true,
                      );
                    }
                  },
                  error: (error) => Center(
                    child: Image.asset(
                      lang
                          ? ImageAssetsManager.noInternetErrorEn
                          : ImageAssetsManager.noInternetErrorAr,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
