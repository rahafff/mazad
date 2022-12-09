import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/global_states/pagination_state.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/global.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/custom_pagination_widget.dart';
import '../../../../core/widgets/no_items_image.dart';
import '../../../../core/widgets/shimmer/shimmer_products_grid_view.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/paginated_product_entity.dart';
import '../manager/products_paginator_cubit.dart';
import '../widgets/custom_animated_search_bar.dart';
import '../widgets/products_grid_view.dart';

const searchAllProductsKey = -1;

class SearchScreen extends StatefulWidget {
  final String search;
  final int? shopId;
  final int? subcategoryId;
  final int? subsubcategoryId;
  final int? categoryId;
  const SearchScreen(
      {Key? key,
      required this.search,
      this.shopId,
      this.subcategoryId,
      this.categoryId,
      this.subsubcategoryId})
      : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController _searchEditingController =
      TextEditingController();
  final GlobalKey<FormState> _searchKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final ProductsPaginatorCubit _productsPaginatorCubit =
      ProductsPaginatorCubit(sl());
  late Map<int?, Future Function()> searchFunctionsMap;
  late int? id;
  bool isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    initializeMapAndExecute();
  }

  void initializeMapAndExecute() {
    assignMap();
    executeMapElementFunction();
  }

  void executeMapElementFunction() {
    id = searchFunctionsMap.keys.firstWhere(
        (element) => element != null && element != searchAllProductsKey,
        orElse: () => searchAllProductsKey);
    searchFunctionsMap[id]?.call();
  }

  void assignMap() {
    searchFunctionsMap = isLoadingMore
        ? {
            widget.shopId: () => _productsPaginatorCubit.emitGetShopProducts(
                shopId: widget.shopId, search: widget.search, loadMore: true),
            widget.subcategoryId: () =>
                _productsPaginatorCubit.emitGetSubcategoryProducts(
                    categoryId: widget.categoryId,
                    subcategoryId: widget.subcategoryId,
                    loadMore: true,
                    search: widget.search),
            searchAllProductsKey: () =>
                _productsPaginatorCubit.emitGetSearchAllProducts(
                    search: widget.search, loadMore: true),
            widget.subsubcategoryId: () =>
                _productsPaginatorCubit.emitGetSubsubcategoryProducts(
                    search: widget.search,
                    loadMore: true,
                    subsubcategoryId: widget.subsubcategoryId,
                    categoryId: widget.categoryId)
          }
        : {
            widget.shopId: () => _productsPaginatorCubit.emitGetShopProducts(
                shopId: widget.shopId, search: widget.search),
            widget.subcategoryId: () =>
                _productsPaginatorCubit.emitGetSubcategoryProducts(
                    categoryId: widget.categoryId,
                    subcategoryId: widget.subcategoryId,
                    search: widget.search),
            searchAllProductsKey: () => _productsPaginatorCubit
                .emitGetSearchAllProducts(search: widget.search),
            widget.subsubcategoryId: () =>
                _productsPaginatorCubit.emitGetSubsubcategoryProducts(
                    search: widget.search,
                    subsubcategoryId: widget.subsubcategoryId,
                    categoryId: widget.categoryId)
          };
  }

  @override
  void dispose() {
    _productsPaginatorCubit.close();
    _searchEditingController.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext searchContext) {
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
                      subsubcategoryId: widget.subsubcategoryId,
                      subcategoryId: widget.subcategoryId,
                      categoryId: widget.categoryId,
                      search: _searchEditingController.text,
                    ),
                  );
                }
              }, //   onEditingComplete: () {
              onFieldSubmitted: (value) {
                _searchEditingController.text = value;
              },
              controller: _searchEditingController,
              appBarTitle: '', //todo ask bahaa
            ),
          ],
        ),
        body: _buildShopProductsConsumer(),
      ),
    );
  }

  _buildShopProductsConsumer() {
    return BlocConsumer<ProductsPaginatorCubit,
        PaginationState<PaginatedProductEntity?>>(
      bloc: _productsPaginatorCubit,
      listener: (context, state) {
        state.whenOrNull(
            error: (NetworkExceptions exception) => Fluttertoast.showToast(
                msg: NetworkExceptions.getErrorMessage(exception),
                toastLength: Toast.LENGTH_SHORT),
            success: (entity, currentPage) {
              _refreshController.refreshCompleted();
              if (currentPage == _productsPaginatorCubit.lastPage) {
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
                  setState(() {
                    isLoadingMore = true;
                  });
                  initializeMapAndExecute();
                },
                onRefresh: () {
                  setState(() {
                    isLoadingMore = false;
                  });
                  initializeMapAndExecute();
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
    );
  }
}
