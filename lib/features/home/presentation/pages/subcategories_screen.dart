import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/shimmer/shimmer_shops_grid_view.dart';
import 'package:elite_auction/features/home/domain/entities/subcategories_entity.dart';
import 'package:elite_auction/features/home/domain/params/subcategories_params.dart';
import 'package:elite_auction/features/home/presentation/widgets/subcategories_widgets/subcategory_gridview_item.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/global.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/no_items_image.dart';
import '../../../../core/widgets/shimmer/shimmer_subcategory_list_view.dart';
import '../manager/subcategories_cubit.dart';
import '../widgets/subcategories_widgets/subcategory_custom_gridview_item.dart';
import '../widgets/subcategories_widgets/subcategory_listview_item.dart';

class SubcategoriesScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const SubcategoriesScreen(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubcategoriesCubit>(
      create: (context) => di.sl<SubcategoriesCubit>()
        ..emitGetSubcategories(
          SubCategoriesParams(categoryId: categoryId),
        ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(categoryName),
            leading: const BackButtonWidget(),
          ),
          body:
              BlocBuilder<SubcategoriesCubit, StandardState<List<Subcategory>>>(
            builder: (BuildContext context, state) {
              return categoryId == 2 || categoryId == 3
                  ? state.when(
                      loading: () => const ShimmerSubcategoryListView(),
                      error: (error) => const SizedBox.shrink(),
                      success: (entity) => entity.isEmpty
                          ? const NoItemsWidget()
                          :  categoryId == 2 ? ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.w, vertical: 4.0.h),
                        itemCount: entity.length,
                        itemBuilder: (BuildContext context, int index) {
                          final subcategory = entity[index];
                          return SubcategoryListviewItem(
                              onTappingAdd: categoryId == 2
                                  ? () {
                                if (!isTokenExist) {
                                  Fluttertoast.showToast(
                                      msg: AppStrings
                                          .youHaveToLoginFirst
                                          .tr());
                                  Navigator.pushNamed(
                                      context, Routes.loginRoute);
                                  return;
                                }
                                Navigator.pushNamed(
                                  context,
                                  Routes.addProductRoute,
                                  arguments: AddProductArguments(
                                      subcategoryName: subcategory
                                          .subcategoryName,
                                      categoryName: categoryName,
                                      subcategoryId:
                                      subcategory.id),
                                );
                              }
                                  : null,
                              onTappingSubcategory: () {
                                Navigator.pushNamed(
                                    context, Routes.subcategoryProducts,
                                    arguments: SubcategoryArguments(
                                        categoryId: categoryId,
                                        subcategoryId: subcategory.id,
                                        subcategoryName:
                                        subcategory.subcategoryName));
                              },
                              subcategoryName:
                              subcategory.subcategoryName,
                              subcategoryImage: EndPoints.baseUrl +
                                  subcategory.subcategoryImage);
                        },
                      ) :
                      GridView.builder(
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.7,
                            crossAxisCount: 2,
                            crossAxisSpacing: 3.0.w,
                            mainAxisSpacing: 2.0.h),
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.w, vertical: 4.0.h),
                        itemCount: entity.length,
                        itemBuilder: (BuildContext context, int index) {
                          final subcategory = entity[index];
                          return SubcategoryCustomGridviewItem(
                              onTappingAdd: categoryId == 2
                                  ? () {
                                if (!isTokenExist) {
                                  Fluttertoast.showToast(
                                      msg: AppStrings
                                          .youHaveToLoginFirst
                                          .tr());
                                  Navigator.pushNamed(
                                      context, Routes.loginRoute);
                                  return;
                                }
                                Navigator.pushNamed(
                                  context,
                                  Routes.addProductRoute,
                                  arguments: AddProductArguments(
                                      subcategoryName: subcategory
                                          .subcategoryName,
                                      categoryName: categoryName,
                                      subcategoryId:
                                      subcategory.id),
                                );
                              }
                                  : null,
                              onTappingSubcategory: () {
                                Navigator.pushNamed(
                                    context, Routes.subcategoryProducts,
                                    arguments: SubcategoryArguments(
                                        categoryId: categoryId,
                                        subcategoryId: subcategory.id,
                                        subcategoryName:
                                        subcategory.subcategoryName));
                              },
                              subcategoryName:
                              subcategory.subcategoryName,
                              subcategoryImage: EndPoints.baseUrl +
                                  subcategory.subcategoryImage);
                        },
                      ) ,
                    )
                  : state.when(
                      loading: () => const ShimmerShopsGridView(),
                      error: (error) => const SizedBox.shrink(),
                      success: (entity) => entity.isEmpty
                          ? const NoItemsWidget()
                          : GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.7,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 3.0.w,
                                      mainAxisSpacing: 2.0.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.0.w, vertical: 4.0.h),
                              itemCount: entity.length,
                              itemBuilder: (BuildContext context, int index) {
                                final subcategory = entity[index];
                                return SubcategoryGridViewItem(
                                    onTappingSubcategory: () {

                                      Navigator.pushNamed(
                                          context, Routes.subcategoryProducts,
                                          arguments: SubcategoryArguments(
                                              categoryId: categoryId,
                                              subcategoryId: subcategory.id,
                                              subcategoryName:
                                                  subcategory.subcategoryName));
                                    },
                                    subcategoryName:
                                        subcategory.subcategoryName,
                                    subcategoryImage: EndPoints.baseUrl +
                                        subcategory.subcategoryImage);
                              },
                            ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
