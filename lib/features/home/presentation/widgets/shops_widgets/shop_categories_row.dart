import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/error/network_exceptions.dart';
import '../../../../../core/global_states/standard_state.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widgets/constant_box_decorations_and_shadows.dart';
import '../../../../../core/widgets/loading_linear.dart';
import '../../../../../core/widgets/sized_box_functions.dart';
import '../../../domain/entities/shop_categories_entity.dart';
import '../../manager/products_paginator_cubit.dart';
import '../../manager/shops_categories_cubit.dart';

class ShopCategoriesRow extends StatefulWidget {
  const ShopCategoriesRow({Key? key, required this.shopId}) : super(key: key);
  final int shopId;
  @override
  State<ShopCategoriesRow> createState() => _ShopCategoriesRowState();
}

//todo refactor
class _ShopCategoriesRowState extends State<ShopCategoriesRow> {
  int? isCategorySelected;
  void _isCategorySelected(int index) {
    setState(() {
      isCategorySelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shopCategoriesContext = context.read<ShopCategoriesCubit>();
    final shopProductsContext = context.read<ProductsPaginatorCubit>();
    return BlocBuilder<ShopCategoriesCubit,
        StandardState<List<ShopCategories>?>>(
      builder: (context, state) {
        return state.when(
          loading: () => const LoadingLinearWidget(),
          error: (NetworkExceptions exception) => SizedBox.shrink(),
          success: (entity) {
            if (entity == null || entity.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                SizedBoxFunctions.verticalSizedBox(2),
                Text(AppStrings.swipeRight.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.0.h, top: 3.0.h),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isCategorySelected = null;
                            });
                            shopCategoriesContext.isFilteringByCategory = false;
                            shopProductsContext.emitGetShopProducts(
                                shopId: widget.shopId);
                          },
                          child: Container(
                            height: 5.0.h,
                            margin: EdgeInsets.all(1.0.w),
                            padding: EdgeInsets.symmetric(horizontal: 1.0.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0.w),
                                shape: BoxShape.rectangle,
                                color: isCategorySelected == null
                                    ? ColorManager.kGreen
                                    : ColorManager.midumeGray,
                                boxShadow: [
                                  ConstantBoxDecorationsAndShadows.lightShadow
                                ]),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                AppStrings.all,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        color: isCategorySelected == null
                                            ? ColorManager.kWhite
                                            : ColorManager.kBlack),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 1.0.h, top: 3.0.h),
                        child: ExpandablePageView.builder(
                          physics: const PageScrollPhysics(),
                          itemCount:
                              shopCategoriesContext.itemCountForShopCategories,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildCategoryRow(
                                categories: entity, index: index);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  _buildCategoryRow({
    required int index,
    required List<ShopCategories> categories,
  }) {
    return Row(
      children: [
        index * 3 < categories.length
            ? _buildCategoryRowItem(
                index: index * 3, category: categories[index * 3])
            : Container(),
        index * 3 + 1 < categories.length
            ? _buildCategoryRowItem(
                category: categories[index * 3 + 1], index: index * 3 + 1)
            : Container(),
        index * 3 + 2 < categories.length
            ? _buildCategoryRowItem(
                category: categories[index * 3 + 2], index: index * 3 + 2)
            : Container(),
      ],
    );
  }

  _buildCategoryRowItem({
    required int index,
    required ShopCategories category,
  }) {
    final shopCategoriesContext = context.read<ShopCategoriesCubit>();
    final shopProductsContext = context.read<ProductsPaginatorCubit>();
    return GestureDetector(
      onTap: () {
        _isCategorySelected(index);
        category.id;
        shopCategoriesContext.isFilteringByCategory = true;
        shopCategoriesContext.categoryId = category.id;

        shopProductsContext.emitGetShopProducts(
            shopId: widget.shopId, shopCategoryId: category.id);
      },
      child: Container(
        width: 20.0.w,
        height: 5.0.h,
        margin: EdgeInsets.all(1.0.w),
        padding: EdgeInsets.symmetric(horizontal: 1.0.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0.w),
            shape: BoxShape.rectangle,
            color: isCategorySelected == index
                ? ColorManager.kGreen
                : ColorManager.midumeGray,
            boxShadow: [ConstantBoxDecorationsAndShadows.lightShadow]),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(category.shopCategoryName.toString(),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: isCategorySelected == index
                      ? ColorManager.kWhite
                      : ColorManager.kBlack)),
        ),
      ),
    );
  }
}
