import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/global_states/standard_state.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/build_indicator.dart';
import '../../../../core/widgets/loading_circular.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/my_product_details_entity.dart';
import '../manager/my_product_details_cubit.dart';
import '../widgets/my_product_details.dart';
import '../widgets/my_product_images_slider.dart';

class MyProductDetailsScreen extends StatefulWidget {
  final int productId;


  const MyProductDetailsScreen({Key? key,
  required this.productId,}
  ) : super(key: key);

  @override
  State<MyProductDetailsScreen> createState() => _MyProductDetailsScreenState();
}

class _MyProductDetailsScreenState extends State<MyProductDetailsScreen>
    with SingleTickerProviderStateMixin {

  int _index = 0;
  final myProductDetailsCubit = MyProductDetailsCubit(sl(),);


  @override
  void initState() {
    myProductDetailsCubit.emitGetMyProductDetails(productId:widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
              body: BlocProvider(create: (context) => MyProductDetailsCubit(sl(),),
                child: BlocBuilder<MyProductDetailsCubit,StandardState<MyProductDetailsEntity>>(
                  bloc:myProductDetailsCubit ,
                  builder:(context, state) {
                    return state.when(
                      loading: () => LoadingCircularWidget(),
                      success: (MyProductDetailsEntity product) {
                        return  SingleChildScrollView(
                          child: Column(children: [
                             MyProductImagesSlider(
                                product: product,
                                onPageChanged: (int index){
                                  setState(
                                        () {
                                      _index = index;
                                    },
                                  );
                                }),
                            Container(
                              color: ColorManager.kWhite,
                              height: 5.0.h,
                            ),
                            BuildIndicator(
                                length:
                                (product!.productImages?.length)!+1 ?? 0,
                                index: _index),
                            const Divider(),
                            MyProductDetails(product: product,),
                          ]),
                        );
                      },
                      error: (error) {
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
              backgroundColor: ColorManager.kWhite,
              resizeToAvoidBottomInset: true,
              appBar:  AppBar(
                title: Text(AppStrings.productDetails.tr()),
                leading: const BackButtonWidget( ),
              ),
            )
        );
      }
}


