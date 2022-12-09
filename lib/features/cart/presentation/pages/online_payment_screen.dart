import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/features/cart/presentation/manager/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/resources/bottom_navigation_bar_Items_Ids.dart';
import '../../../../core/resources/constant_backend_values.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import '../../../app_navigation_bar/presentation/manager/app_navigation_bar_badges_cubit.dart';
import '../../domain/bodies/checkout_body.dart';
import '../manager/checkout_cubit.dart';

class OnlinePaymentScreen extends StatefulWidget {
  @override
  _OnlinePaymentScreenState createState() => _OnlinePaymentScreenState();
}

class _OnlinePaymentScreenState extends State<OnlinePaymentScreen> {
  @override
  void initState() {
    print("payment id ${context.read<CardPaymentCubit>().paymentId}");
    print("payment url ${context.read<CardPaymentCubit>().paymentUrl}");
    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.shippingAndPayment.tr(),
        ),
        leading: const BackButtonWidget(),
      ),
      body:
          BlocConsumer<CheckoutCubit, PostingState<EmptySuccessResponseEntity>>(
        listener: (context, state) {
          state.whenOrNull(
            success: (data) {
              context
                  .read<AppBottomNavigationBarIndexChangerCubit>()
                  .changeScreen(homeId);
              context
                  .read<AppNavigationBarBadgesCubit>()
                  .emitGetCartAndWishlistItemCount();
              Fluttertoast.showToast(
                  msg: data.message, toastLength: Toast.LENGTH_SHORT);
              Navigator.popAndPushNamed(context, Routes.ordersRout);
            },
            error: (networkExceptions) {
              context
                  .read<AppBottomNavigationBarIndexChangerCubit>()
                  .changeScreen(homeId);
              context
                  .read<AppNavigationBarBadgesCubit>()
                  .emitGetCartAndWishlistItemCount();
              Fluttertoast.showToast(
                msg: NetworkExceptions.getErrorMessage(networkExceptions),
                toastLength: Toast.LENGTH_SHORT,
              );
              Navigator.pop(context);
            },
          );
        },
        builder: (context, state) => WebView(
          initialUrl: context.read<CardPaymentCubit>().paymentUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (controller) {},
          onPageFinished: (controller) {
            Future.delayed(const Duration(milliseconds: 1234), () {
              if (mounted) setState(() {});
            });
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url
                .startsWith('https://api.malnokhba.qa/api/payment_redirect')) {
              context.read<CheckoutCubit>().emitCheckout(
                    CheckOutBody(
                      paymentId: context.read<CardPaymentCubit>().paymentId,
                      zoneNumber: AppSharedPreferences.zoneNumber!,
                      street: AppSharedPreferences.street!,
                      buildingNumber: AppSharedPreferences.buildingNumber!,
                      paymentMethod: PaymentMethods.online,
                      appartement: AppSharedPreferences.appartment,
                      floorNumber: AppSharedPreferences.floor,
                      locationName: AppSharedPreferences.locationName!,
                        latitude: AppSharedPreferences.latitude!,longitude:AppSharedPreferences.longitude!
                    ),
                  );
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}
