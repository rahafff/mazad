import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/constant_backend_values.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/features/settings/domain/entities/order_entity.dart';
import 'package:elite_auction/features/settings/domain/params/order_details_params.dart';
import 'package:elite_auction/features/settings/presentation/pages/order_details_screen.dart';
import 'package:elite_auction/features/settings/presentation/widgets/order_status_box.dart';
import 'package:elite_auction/features/settings/presentation/widgets/order_tracking_dots.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../core/resources/strings_manager.dart';
import '../../../../../../../../core/utils/global.dart';
import '../manager/order_details_cubit.dart';

class OrderTrackScreen extends StatefulWidget {
  const OrderTrackScreen(
      {Key? key, required this.orderId, required this.status})
      : super(key: key);
  final int orderId;
  final String status;

  @override
  _OrderTrackScreenState createState() => _OrderTrackScreenState();
}

class _OrderTrackScreenState extends State<OrderTrackScreen> {
  OrderStatus orderStatus = OrderStatus();

  @override
  void initState() {
    int statusIndex = orderStatus.orderStatusesAsList.indexOf(widget.status);
    for (int index = 0; index <= statusIndex; index++) {
      orderStatus.statusesState[orderStatus.orderStatusesAsList[index]] = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderDetailsCubit>(
      create: (_) => di.sl<OrderDetailsCubit>()
        ..emitGetOrderDetails(
          OrderDetailsParams(orderId: widget.orderId),
        ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.orderTracking.tr(),
            ),
            leading: const BackButtonWidget(),
          ),
          body: BlocBuilder<OrderDetailsCubit,
              StandardState<PaginatedOrderEntity>>(
            builder: (context, state) {
              return state.when(
                loading: () => LoadingCircularWidget(),
                success: (data) => ListView(
                  shrinkWrap: true,
                  primary: false,
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 5.0.h),
                  children: [
                    ListTile(
                      title: Text(
                        "${AppStrings.yourOrderTrackCode.tr()} : ${data.orderCode}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    OrderStatusBox(
                      orderStatus: orderStatus
                          .statusesState[AppStrings.pending.toLowerCase()]!,
                      orderStatusTitle: AppStrings.pending.tr(),
                      orderStatusDescription: AppStrings.pendingWords.tr(),
                    ),
                    OrderTrackingDots(
                        isPassed: orderStatus
                            .statusesState[AppStrings.pending.toLowerCase()]!),
                    OrderStatusBox(
                      orderStatus: orderStatus
                          .statusesState[AppStrings.accepted.toLowerCase()]!,
                      orderStatusTitle: AppStrings.verified.tr(),
                      orderStatusDescription: AppStrings.verifiedWords.tr(),
                    ),
                    OrderTrackingDots(
                      isPassed: orderStatus
                          .statusesState[AppStrings.accepted.toLowerCase()]!,
                    ),
                    OrderStatusBox(
                      orderStatus: orderStatus
                          .statusesState[AppStrings.delivering.toLowerCase()]!,
                      orderStatusTitle: AppStrings.onTheWay.tr(),
                      orderStatusDescription: AppStrings.onTheWayWords.tr(),
                    ),
                    OrderTrackingDots(
                      isPassed: orderStatus
                          .statusesState[AppStrings.delivering.toLowerCase()]!,
                    ),
                    OrderStatusBox(
                      orderStatus: orderStatus
                          .statusesState[AppStrings.delivered.toLowerCase()]!,
                      orderStatusTitle: AppStrings.delivered.tr(),
                      orderStatusDescription: AppStrings.deliveredWords.tr(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderDetailsScreen(order: data),
                          ),
                        );
                      },
                      child: Text(
                        AppStrings.seeOrderDetails.tr(),
                      ),
                    ),
                  ],
                ),
                error: (networkExceptions) => lang
                    ? Center(
                        child:
                            Image.asset(ImageAssetsManager.noInternetErrorEn),
                      )
                    : Center(
                        child:
                            Image.asset(ImageAssetsManager.noInternetErrorAr),
                      ),
              );
            },
          ),
        ),
      ),
    );
    //
  }
}
