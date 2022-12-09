import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/custom_pagination_widget.dart';
import 'package:elite_auction/features/home/domain/entities/shop_entity.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/global_states/pagination_state.dart';
import '../../../../core/utils/global.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/no_items_image.dart';
import '../../../../core/widgets/shimmer/shimmer_shops_grid_view.dart';
import '../manager/shops_cubit.dart';
import '../widgets/shops_widgets/shops_grid_view.dart';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({Key? key}) : super(key: key);

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
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
    return BlocProvider<ShopsCubit>(
      create: (_) => di.sl<ShopsCubit>()..emitGetAllShops(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text(AppStrings.eliteShops.tr()),
              leading: const BackButtonWidget()),
          body: BlocConsumer<ShopsCubit, PaginationState<ShopEntity?>>(
            listener: (context, state) {
              state.whenOrNull(
                  error: (NetworkExceptions exception) =>
                      Fluttertoast.showToast(
                          msg: NetworkExceptions.getErrorMessage(exception),
                          toastLength: Toast.LENGTH_SHORT),
                  success: (entity, currentPage) {
                    _refreshController.refreshCompleted();
                    if (currentPage == context.read<ShopsCubit>().lastPage) {
                      _refreshController.loadNoData();
                    } else {
                      _refreshController.loadComplete();
                    }
                  });
            },
            builder: (context, state) {
              return state.when(
                loading: () => const ShimmerShopsGridView(),
                success: (entity, _) {
                  if (entity.isEmpty) {
                    return const NoItemsWidget();
                  } else {
                    return CustomPaginationWidget(
                      enablePullUp: true,
                      endOfScrollingMessage: AppStrings.noMoreShops,
                      itemCount: entity.length,
                      listTobePaginated: ShopsGridView(shops: entity),
                      refreshController: _refreshController,
                      onLoading: () => context
                          .read<ShopsCubit>()
                          .emitGetAllShops(loadMore: true),
                      onRefresh: () =>
                          context.read<ShopsCubit>().emitGetAllShops(),
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
      ),
    );
  }
}
