import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:elite_auction/features/home/presentation/manager/slided_products_cubit.dart';
import 'package:elite_auction/features/home/presentation/widgets/products_slider_builder.dart';
import 'package:elite_auction/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/assets_manager.dart';
import '../widgets/home_widgets/advertisements_slider.dart';
import '../widgets/home_widgets/categories_grid.dart';
import '../widgets/home_widgets/elite_shops_button.dart';
import '../widgets/home_widgets/home_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SlidedProductsCubit _mostPurchasedCubit = SlidedProductsCubit(sl());

  @override
  void initState() {
    super.initState();
    _mostPurchasedCubit.emitGetMostPurchasedProducts();
  }

  @override
  void dispose() {
    _mostPurchasedCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Image.asset(
            ImageAssetsManager.eliteWords,
            width: 50.w,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxFunctions.verticalSizedBox(1),
              const HomeSearchBar(),
              SizedBoxFunctions.verticalSizedBox(3),
              const AdvertisementsSlider(),
              SizedBoxFunctions.verticalSizedBox(3),
              const CategoriesGrid(),
              SizedBoxFunctions.verticalSizedBox(3),
              const EliteShopsButton(),
              SizedBoxFunctions.verticalSizedBox(3),
              _buildHomeTexts(
                  context: context, content: AppStrings.mostPurchased),
              ProductsSliderBuilder(cubit: _mostPurchasedCubit),
            ],
          ),
        ),
      ),
    );
  }

  _buildHomeTexts({required BuildContext context, required String content}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: Text(content.tr(), style: Theme.of(context).textTheme.subtitle1),
    );
  }
}
