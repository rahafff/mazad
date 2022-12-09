import 'package:elite_auction/core/global_states/pagination_state.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:elite_auction/features/home/domain/entities/paginated_product_entity.dart';
import 'package:elite_auction/features/home/presentation/widgets/products_grid_view.dart';
import 'package:elite_auction/features/home/presentation/widgets/shops_widgets/shop_categories_row.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/global.dart';
import '../../../../core/widgets/custom_pagination_widget.dart';
import '../../../../core/widgets/no_items_image.dart';
import '../../../../core/widgets/shimmer/shimmer_products_grid_view.dart';
import '../manager/products_paginator_cubit.dart';
import '../manager/shops_categories_cubit.dart';
import '../widgets/custom_animated_search_bar.dart';

class ShopScreen extends StatefulWidget {
  final int shopId;
  final String shopName;
  const ShopScreen({Key? key, required this.shopName, required this.shopId})
      : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController _searchEditingController =
      TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _searchKey = GlobalKey();

  @override
  void dispose() {
    _searchEditingController.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsPaginatorCubit>(
          create: (_) => di.sl<ProductsPaginatorCubit>()
            ..emitGetShopProducts(shopId: widget.shopId),
        ),
        BlocProvider<ShopCategoriesCubit>(
          create: (_) => di.sl<ShopCategoriesCubit>()
            ..emitGetShopCategories(widget.shopId),
        ),
      ],
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButtonWidget(),
              actions: [
                CustomAnimatedSearchBar(
                  searchFieldKey: _searchKey,
                  onEditingComplete: () {
                    if (_searchKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.search,
                        arguments: SearchArguments(
                          shopId: widget.shopId,
                          search: _searchEditingController.text,
                        ),
                      );
                    }
                  }, //   onEditingComplete: () {
                  onFieldSubmitted: (value) {
                    _searchEditingController.text = value;
                  },
                  controller: _searchEditingController,
                  appBarTitle: widget.shopName,
                ),
              ],
            ),
            body: Column(
              children: [
                ShopCategoriesRow(shopId: widget.shopId),
                SizedBoxFunctions.verticalSizedBox(2),
                _buildShopProductsConsumer(context),
              ],
            ),
          ),
        );
      }),
    );
  }

  _buildShopProductsConsumer(BuildContext context) {
    final shopProductsContext = context.read<ProductsPaginatorCubit>();
    final shopCategoriesContext = context.read<ShopCategoriesCubit>();
    return Flexible(
        child: BlocConsumer<ProductsPaginatorCubit,
            PaginationState<PaginatedProductEntity?>>(
      bloc: shopProductsContext..emitGetShopProducts(shopId: widget.shopId),
      listener: (context, state) {
        state.whenOrNull(
            error: (NetworkExceptions exception) => Fluttertoast.showToast(
                msg: NetworkExceptions.getErrorMessage(exception),
                toastLength: Toast.LENGTH_SHORT),
            success: (entity, currentPage) {
              _refreshController.refreshCompleted();
              if (currentPage == shopProductsContext.lastPage) {
                _refreshController.loadNoData();
              } else {
                _refreshController.loadComplete();
              }
            });
      },
      builder: (context, state) {
        return state.when(
          loading: () => const ShimmerProductsGridView(),
          success: (entity, _) {
            if (entity.isEmpty) {
              return const NoItemsWidget();
            } else {
              return CustomPaginationWidget(
                enablePullUp: true,
                endOfScrollingMessage: AppStrings.noMoreProducts,
                itemCount: entity.length,
                listTobePaginated: ProductsGridView(products: entity),
                refreshController: _refreshController,
                onLoading: () {
                  if (!shopCategoriesContext.isFilteringByCategory) {
                    shopProductsContext.emitGetShopProducts(
                        loadMore: true, shopId: widget.shopId);
                  }
                  shopProductsContext.emitGetShopProducts(
                      shopId: widget.shopId,
                      loadMore: true,
                      shopCategoryId: shopCategoriesContext.categoryId);
                },
                onRefresh: () {
                  if (!shopCategoriesContext.isFilteringByCategory) {
                    shopProductsContext.emitGetShopProducts(
                        shopId: widget.shopId);
                  }
                  shopProductsContext.emitGetShopProducts(
                      shopId: widget.shopId,
                      shopCategoryId: shopCategoriesContext.categoryId);
                },
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
    ));
  }
}
