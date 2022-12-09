import 'package:elite_auction/core/global_states/pagination_state.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/no_items_image.dart';
import 'package:elite_auction/core/widgets/shimmer/shimmer_products_grid_view.dart';
import 'package:elite_auction/features/home/domain/entities/paginated_product_entity.dart';
import 'package:elite_auction/features/home/presentation/manager/customers_products_paginator_cubit.dart';
import 'package:elite_auction/features/home/presentation/widgets/products_grid_view.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/error/network_exceptions.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/global.dart';
import '../../../../core/widgets/custom_pagination_widget.dart';
import '../../../../injection_container.dart';
import '../../../settings/domain/entities/my_product_details_entity.dart';
import '../../../settings/presentation/widgets/my_product_listview_item.dart';
import '../manager/products_paginator_cubit.dart';
import '../widgets/custom_animated_search_bar.dart';

class SubsubcategoryProductsScreen extends StatefulWidget {
  final int categoryId;
  final int subsubcategoryId;
  final String subsubcategoryName;

  const SubsubcategoryProductsScreen(
      {Key? key,
      required this.categoryId,
      required this.subsubcategoryId,
      required this.subsubcategoryName})
      : super(key: key);

  @override
  State<SubsubcategoryProductsScreen> createState() =>
      _SubsubcategoryProductsScreenState();
}

class _SubsubcategoryProductsScreenState
    extends State<SubsubcategoryProductsScreen> with TickerProviderStateMixin {
  final TextEditingController _searchEditingController =
      TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController;
  final GlobalKey<FormState> _searchKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(() {});
  }

  @override
  void dispose() {
    _searchEditingController.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsPaginatorCubit>(
          create: (_) => di.sl<ProductsPaginatorCubit>(),
        ),
        BlocProvider<AllCustomersProductsCubit>(
          create: (context) => sl<AllCustomersProductsCubit>()
            ..emitGetAllCustomersProducts(
                subsubcategoryId: widget.subsubcategoryId),
        ),
      ],
      child: SafeArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
                appBar: AppBar(
                  leading: const BackButtonWidget(),
                  actions: widget.categoryId == 2
                      ? [
                          CustomAnimatedSearchBar(
                            searchFieldKey: _searchKey,
                            onEditingComplete: () {
                              if (_searchKey.currentState!.validate()) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  Routes.search,
                                  arguments: SearchArguments(
                                    subsubcategoryId: widget.subsubcategoryId,
                                    search: _searchEditingController.text,
                                  ),
                                );
                              }
                            },
                            onFieldSubmitted: (value) {
                              _searchEditingController.text = value;
                            },
                            controller: _searchEditingController,
                            appBarTitle: widget.subsubcategoryName,
                          ),
                        ]
                      : null,
                ),
                body: widget.categoryId == 2
                    ? _buildSubcategoryCustomerProducts(context)
                    : _buildSubsubcategoryProductsConsumer(context));
          },
        ),
      ),
    );
  }

  _buildSubcategoryCustomerProducts(BuildContext context) {
    final cubitContext = context.read<AllCustomersProductsCubit>();
    return BlocConsumer<AllCustomersProductsCubit,
        PaginationState<MyProductDetailsEntity?>>(
      bloc: cubitContext
        ..emitGetAllCustomersProducts(
            subsubcategoryId: widget.subsubcategoryId),
      listener: (context, state) {
        state.whenOrNull(
            error: (NetworkExceptions exception) => Fluttertoast.showToast(
                msg: NetworkExceptions.getErrorMessage(exception),
                toastLength: Toast.LENGTH_SHORT),
            success: (entity, currentPage) {
              _refreshController.refreshCompleted();
              if (currentPage == cubitContext.lastPage) {
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
                listTobePaginated: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 5.0.w),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: entity.length,
                    itemBuilder: (BuildContext context, index) {
                      final product = entity[index];
                      if (index == (entity.length)) {
                        return SizedBox(
                          height: 4.5.h,
                        );
                      }

                      int? statusCode =
                          product?.productStatus?.productStatusCode;
                      if (statusCode == 1) {
                        return MyProductListviewItem(
                          image: EndPoints.baseUrl +
                              product!.productMainImage.toString(),
                          name:
                              product.productDetails![0].productName.toString(),
                          price: product.productPrice.toString(),
                          ownerName: product.user?.fullName,
                          statusCode: product.productStatus!.productStatusCode!,
                          isMine: false,
                          onTap: () {
                            isCustomerScreen = true;
                            Navigator.pushNamed(
                                context, Routes.myProductDetails,
                                arguments: MyProductDetailsArguments(
                                    productId:
                                        product.productDetails![0].productId!));
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                refreshController: _refreshController,
                onLoading: () => cubitContext.emitGetAllCustomersProducts(
                    subsubcategoryId: widget.subsubcategoryId, loadMore: true),
                onRefresh: () => cubitContext.emitGetAllCustomersProducts(
                    subsubcategoryId: widget.subsubcategoryId),
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

  _buildSubsubcategoryProductsConsumer(BuildContext context) {
    final cubitContext = context.read<ProductsPaginatorCubit>();
    return BlocConsumer<ProductsPaginatorCubit,
        PaginationState<PaginatedProductEntity?>>(
      bloc: cubitContext
        ..emitGetSubsubcategoryProducts(
            categoryId: widget.categoryId,
            subsubcategoryId: widget.subsubcategoryId),
      listener: (context, state) {
        state.whenOrNull(
            error: (NetworkExceptions exception) => Fluttertoast.showToast(
                msg: NetworkExceptions.getErrorMessage(exception),
                toastLength: Toast.LENGTH_SHORT),
            success: (entity, currentPage) {
              _refreshController.refreshCompleted();
              if (currentPage == cubitContext.lastPage) {
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
                onLoading: () => cubitContext.emitGetSubsubcategoryProducts(
                    categoryId: widget.categoryId,
                    subsubcategoryId: widget.subsubcategoryId,
                    loadMore: true),
                onRefresh: () => cubitContext.emitGetSubsubcategoryProducts(
                    categoryId: widget.categoryId,
                    subsubcategoryId: widget.subsubcategoryId),
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
