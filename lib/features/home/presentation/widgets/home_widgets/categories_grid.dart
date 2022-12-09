import 'package:elite_auction/core/widgets/shimmer/shimmer_categories_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/global_states/standard_state.dart';
import '../../../../../injection_container.dart' as di;
import '../../../domain/entities/categories_entity.dart';
import '../../manager/categories_cubit.dart';
import 'categories_grid_item.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesCubit>(
      create: (context) => di.sl<CategoriesCubit>()..emitGetCategories(),
      child: Builder(builder: (context) {
        return BlocBuilder<CategoriesCubit, StandardState<List<Category>>>(
          builder: (context, state) {
            return state.when(
                loading: () => const ShimmerCategoriesGrid(),
                error: (error) => const SizedBox.shrink(),
                success: (entity) => entity.isEmpty
                    ? const SizedBox.shrink()
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entity.length,
                        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoriesGridItem(category: entity[index]);
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0.w,
                          mainAxisSpacing: 3.0.h,
                          childAspectRatio: 1,
                        ),
                      ));
          },
        );
      }),
    );
  }
}
