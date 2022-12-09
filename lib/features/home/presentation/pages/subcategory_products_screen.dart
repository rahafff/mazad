import 'package:elite_auction/core/global_states/pagination_state.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/no_items_image.dart';
import 'package:elite_auction/core/widgets/shimmer/shimmer_products_grid_view.dart';
import 'package:elite_auction/features/home/domain/entities/paginated_product_entity.dart';
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
import '../../domain/entities/subsubcategories_entity.dart';
import '../manager/customers_products_paginator_cubit.dart';
import '../manager/products_paginator_cubit.dart';
import '../manager/subsubcategories_cubit.dart';
import '../widgets/custom_animated_search_bar.dart';
import '../widgets/subcategories_widgets/subcategory_gridview_item.dart';
import '../widgets/subcategories_widgets/subsubcategory_listview_item.dart';

class SubcategoryProductsScreen extends StatefulWidget {
  final int categoryId;
  final int subcategoryId;
  final String subcategoryName;

  const SubcategoryProductsScreen(
      {Key? key,
      required this.subcategoryName,
      required this.categoryId,
      required this.subcategoryId})
      : super(key: key);

  @override
  State<SubcategoryProductsScreen> createState() =>
      _SubcategoryProductsScreenState();
}

class _SubcategoryProductsScreenState extends State<SubcategoryProductsScreen>
    with TickerProviderStateMixin {
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
          create: (_) => di.sl<AllCustomersProductsCubit>(),
        ),
        BlocProvider<SubsubcategoriesCubit>(
          create: (context) => sl<SubsubcategoriesCubit>()
            ..emitGetSubsubategories(widget.subcategoryId),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocBuilder<SubsubcategoriesCubit,
            StandardState<List<Subsubcategory?>>>(
          builder: (context, state) {
            return state.when(
              loading: () => Scaffold(
                appBar: AppBar(
                  leading: const BackButtonWidget(),
                  title: Text(widget.subcategoryName),
                ),
              ),
              success: (data) => data.isEmpty
                  ? _buildSubcategoryProductsWhenThereAreNoSubsubcategories(
                      context)
                  : _buildSubsubcategoriesGridviewWhenThereAreSubsubcategories(
                      data),
              error: (networkExceptions) => const NoItemsWidget(),
            );
          },
        );
      }),
    );
  }

  SafeArea _buildSubcategoryProductsWhenThereAreNoSubsubcategories(
      BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBar(
              leading: const BackButtonWidget(),
              actions:widget.categoryId==2? [
                CustomAnimatedSearchBar(
                  searchFieldKey: _searchKey,
                  onEditingComplete: () {
                    if (_searchKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.search,
                        arguments: SearchArguments(
                          subcategoryId: widget.subcategoryId,
                          categoryId: widget.categoryId,
                          search: _searchEditingController.text,
                        ),
                      );
                    }
                  },
                  onFieldSubmitted: (value) {
                    _searchEditingController.text = value;
                  },
                  controller: _searchEditingController,
                  appBarTitle: widget.subcategoryName,
                ),
              ]:null,
            ),
            body: widget.categoryId == 2
                ? _buildSubcategoryCustomerProducts(context)
                : _buildSubcategoryProductsConsumer(context));
      }),
    );
  }

  _buildSubcategoryCustomerProducts(BuildContext context) {
    final cubitContext = context.read<AllCustomersProductsCubit>();
    return BlocConsumer<AllCustomersProductsCubit,
        PaginationState<MyProductDetailsEntity?>>(
      bloc: cubitContext
        ..emitGetAllCustomersProducts(subcategoryId: widget.subcategoryId),
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
                      return MyProductListviewItem(
                        image: EndPoints.baseUrl + product!.productMainImage!,
                        name: lang? product.productDetails![0].productName!:product.productDetails![1].productName!,
                        price: product.productPrice.toString(),
                        ownerName: product.user!.fullName!,
                        statusCode: product.productStatus!.productStatusCode!,
                        isMine: false,
                        onTap: () {
                          Navigator.pushNamed(
                    context, Routes.myProductDetails,arguments: MyProductDetailsArguments(productId: lang? product.productDetails![0].productId!:product.productDetails![1].productId!
                   )
                );

                        },
                      );
                    }),
                refreshController: _refreshController,
                onLoading: () => cubitContext.emitGetAllCustomersProducts(
                    subcategoryId: widget.subcategoryId, loadMore: true),
                onRefresh: () => cubitContext.emitGetAllCustomersProducts(
                    subcategoryId: widget.subcategoryId),
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

  SafeArea _buildSubsubcategoriesGridviewWhenThereAreSubsubcategories(
      List<Subsubcategory?> data) {
    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButtonWidget(),
            title: Text(widget.subcategoryName),
          ),
          body: widget.categoryId==2? GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7,
                crossAxisCount: 2,
                crossAxisSpacing: 3.0.w,
                mainAxisSpacing: 2.0.h),
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 4.0.h),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final subsubcategory = data[index];
              return SubcategoryGridViewItem(
                  onTappingSubcategory: () {
                    Navigator.pushNamed(context, Routes.subsubcategoryProducts,
                        arguments: SubsubcategoryArguments(
                            categoryId: widget.categoryId,
                            subsubcategoryId: subsubcategory?.id as int,
                            subsubcategoryName:
                                subsubcategory!.subsubcategoryName!));
                  },
                  subcategoryName: subsubcategory!.subsubcategoryName!,
                  subcategoryImage:
                      EndPoints.baseUrl + subsubcategory.subsubcategoryImage!);
            },
          ) :
          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 4.0.h),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final subsubcategory = data[index];
              return SubsubcategoryListviewItem(
                  onTappingSubcategory: () {
                    Navigator.pushNamed(context, Routes.subsubcategoryProducts,
                        arguments: SubsubcategoryArguments(
                            categoryId: widget.categoryId,
                            subsubcategoryId: subsubcategory?.id as int,
                            subsubcategoryName:
                            subsubcategory!.subsubcategoryName!));
                  },
                  subcategoryName: subsubcategory!.subsubcategoryName!,
                  subcategoryImage:
                  EndPoints.baseUrl + subsubcategory.subsubcategoryImage!);
            },
          ) ,
        );
      }),
    );
  }

  _buildSubcategoryProductsConsumer(BuildContext context) {
    final cubitContext = context.read<ProductsPaginatorCubit>();
    return BlocConsumer<ProductsPaginatorCubit,
        PaginationState<PaginatedProductEntity?>>(
      bloc: cubitContext
        ..emitGetSubcategoryProducts(
            categoryId: widget.categoryId, subcategoryId: widget.subcategoryId),
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
                onLoading: () => cubitContext.emitGetSubcategoryProducts(
                    categoryId: widget.categoryId,
                    subcategoryId: widget.subcategoryId,
                    loadMore: true),
                onRefresh: () => cubitContext.emitGetSubcategoryProducts(
                    categoryId: widget.categoryId,
                    subcategoryId: widget.subcategoryId),
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
