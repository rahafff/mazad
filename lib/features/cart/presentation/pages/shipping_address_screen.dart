import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/app_validation_functions.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/core/widgets/app_functions.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/custom_text_form_field.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:elite_auction/features/cart/domain/bodies/checkout_body.dart';
import 'package:elite_auction/features/cart/domain/entities/online_payment_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/search_response_entity.dart';
import 'package:elite_auction/features/cart/presentation/manager/checkout_cubit.dart';
import 'package:elite_auction/features/cart/presentation/manager/payment_cubit.dart';
import 'package:elite_auction/features/cart/presentation/pages/online_payment_screen.dart';
import 'package:elite_auction/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/global_states/posting_state.dart';
import '../../../../core/resources/bottom_navigation_bar_Items_Ids.dart';
import '../../../../core/resources/constant_backend_values.dart';
import '../../../../core/widgets/constant_box_decorations_and_shadows.dart';
import '../../../app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import '../../../app_navigation_bar/presentation/manager/app_navigation_bar_badges_cubit.dart';
import '../manager/location_cubit.dart';

enum PaymentMethod {
  Cash,
  Visa,
}

const kGoogleApiKey = "AIzaSyAIO-8bXHu3gUxOXDpxCr6cz91i20Ex8IA";

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final TextEditingController _zoneNumber =
      TextEditingController(text: AppSharedPreferences.zoneNumber ?? '');
  final TextEditingController _street =
      TextEditingController(text: AppSharedPreferences.street ?? '');

  final TextEditingController _buildingNumber =
      TextEditingController(text: AppSharedPreferences.buildingNumber ?? '');
  final TextEditingController _search = TextEditingController();
  final TextEditingController _apartment = TextEditingController();
  final TextEditingController _floor = TextEditingController();
  final TextEditingController _locationName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPaymentMethodSelected = false;
  String? paymentWay;
  bool isSearching = true;
  bool tapped = false;
  var uid = const Uuid();
  String sessionToken = '121231321';
  final locationCubit = LocationCubit(sl());
  @override
  void dispose() {
    _zoneNumber.dispose();
    _street.dispose();
    _buildingNumber.dispose();
    _search.dispose();
    _apartment.dispose();
    _floor.dispose();
    _locationName.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _search.addListener(() {
      onChange();
    });
  }

  void onChange() {
    setState(() {
      sessionToken = uid.v4();
    });

    getSuggestions(_search.text);
  }

  void getSuggestions(String input) {
    locationCubit.emitGetLocationSearchResults(input, sessionToken);
  }
  void placeDetailes(String palceId) {
    print(palceId);
    locationCubit.locationDetailes(palceId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationCubit>(
      create: (context) => sl<LocationCubit>(),
      child: GestureDetector(
        onTap: () {
          AppFunctions.unfocus(context);
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.shippingAndPayment.tr(),
              ),
              leading: const BackButtonWidget(),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5.0.h),
                children: [
                  _buildAddressForm(context),
                  SizedBoxFunctions.verticalSizedBox(5),
                  Container(
                    padding: EdgeInsets.all(5.0.w),
                    decoration: ConstantBoxDecorationsAndShadows
                        .RoundedBoxWithLightShadow,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.paymentMethods.tr(),
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBoxFunctions.verticalSizedBox(2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildCashPayment(),
                            SizedBoxFunctions.horizontalSizedBox(2),
                            _buildCardPayment(),
                          ],
                        ),
                        SizedBoxFunctions.verticalSizedBox(5),
                        paymentWay == PaymentMethod.Visa.toString()
                            ? BlocConsumer<CardPaymentCubit,
                                PostingState<BaseEntity<OnlinePaymentEntity>>>(
                                listener: (context, state) {
                                  state.whenOrNull(
                                    success: (data) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OnlinePaymentScreen(),
                                        ),
                                      );
                                    },
                                  );
                                  // if (state is OnlinePaymentSuccessful) {
                                  //   context
                                  //       .read<OnlinePaymentCubit>()
                                  //       .paymentUrl =
                                  //       state.paymentOnlineResponseModel?.payment
                                  //           ?.paymentUrl;
                                  //   context.read<OnlinePaymentCubit>().paymentId =
                                  //       state.paymentOnlineResponseModel?.payment
                                  //           ?.paymentId;
                                  //
                                  //   Navigator.pushReplacement(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               OnlinePaymentScreen()));
                                  // }
                                },
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    loading: () => LoadingCircularWidget(),
                                    orElse: () => Center(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: paymentWay ==
                                                  PaymentMethod.Visa.toString()
                                              ? ColorManager.kGreen
                                              : ColorManager.grayText,
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                                  .validate() &&
                                              paymentWay ==
                                                  PaymentMethod.Visa
                                                      .toString()) {
                                            context
                                                .read<CardPaymentCubit>()
                                                .pay();
                                            AppSharedPreferences.zoneNumber =
                                                _zoneNumber.text.toString();
                                            AppSharedPreferences
                                                    .buildingNumber =
                                                _buildingNumber.text.toString();
                                            AppSharedPreferences.street =
                                                _street.text;
                                          }
                                        },
                                        child: Text(
                                          AppStrings.confirmTheOperation.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : BlocConsumer<CheckoutCubit,
                                PostingState<EmptySuccessResponseEntity>>(
                                listener: (context, state) {
                                  state.whenOrNull(
                                    success: (data) {
                                      context
                                          .read<
                                              AppBottomNavigationBarIndexChangerCubit>()
                                          .changeScreen(homeId);
                                      context
                                          .read<AppNavigationBarBadgesCubit>()
                                          .emitGetCartAndWishlistItemCount();
                                      Fluttertoast.showToast(
                                          msg: data.message,
                                          toastLength: Toast.LENGTH_SHORT);
                                      Navigator.popAndPushNamed(
                                          context, Routes.ordersRout);
                                    },
                                    error: (networkExceptions) {
                                      context
                                          .read<
                                              AppBottomNavigationBarIndexChangerCubit>()
                                          .changeScreen(homeId);
                                      context
                                          .read<AppNavigationBarBadgesCubit>()
                                          .emitGetCartAndWishlistItemCount();
                                      Fluttertoast.showToast(
                                        msg: NetworkExceptions.getErrorMessage(
                                            networkExceptions),
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
/*
                                      Navigator.pop(context);
*/
                                    },
                                  );
                                },
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    loading: () => LoadingCircularWidget(),
                                    orElse: () => Center(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: paymentWay ==
                                                      'PaymentMethod.Cash' ||
                                                  paymentWay ==
                                                      'PaymentMethod.Visa'
                                              ? ColorManager.kGreen
                                              : ColorManager.grayText,
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                                  .validate() &&
                                              paymentWay ==
                                                  'PaymentMethod.Cash') {
                                            AppSharedPreferences.zoneNumber =
                                                _zoneNumber.text;
                                            AppSharedPreferences
                                                    .buildingNumber =
                                                _buildingNumber.text;
                                            AppSharedPreferences.street =
                                                _street.text;
                                               //  AppSharedPreferences.locationName =
                                               // _locationName.text='address';
                                                AppSharedPreferences.floor =
                                              _floor.text;
                                                AppSharedPreferences.appartment =
                                                _apartment.text;

                                            context
                                                .read<CheckoutCubit>()
                                                .emitCheckout(CheckOutBody(
                                                  zoneNumber:
                                                      AppSharedPreferences
                                                          .zoneNumber!,
                                                  street: AppSharedPreferences
                                                      .street!,
                                                  buildingNumber:
                                                      AppSharedPreferences
                                                          .buildingNumber!,
                                                  paymentMethod: PaymentMethods
                                                      .cashOnDelivery,
                                                      appartement: AppSharedPreferences.appartment,
                                                      floorNumber:AppSharedPreferences.floor ,
                                                      locationName: 'address' ,
                                              latitude: AppSharedPreferences.latitude!,longitude:AppSharedPreferences.longitude!
                                                ));
                                          }
                                        },
                                        child: Text(
                                          AppStrings.confirmTheOperation.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildCardPayment() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            paymentWay = PaymentMethod.Visa.toString();
          });
        },
        child: Container(
          height: 15.0.h,
          padding: EdgeInsets.all(1.0.w),
          decoration: paymentWay == PaymentMethod.Visa.toString()
              ? BoxDecoration(
                  shape: BoxShape.rectangle,
                  //TODO use this color when available master card
                  color: const Color(0xff365655),
                  // color: Colors.grey,Visa
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(3.0.w)),
                )
              : BoxDecoration(
                  shape: BoxShape.rectangle,
                  //TODO use this color when available master card
                  // color: const Color(0xff365655),
                  color: Colors.grey,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(3.0.w)),
                ),
          child: Center(
            child: SizedBox(
              width: 12.w,
              child: Image.asset(
                ImageAssetsManager.masterCard,
                scale: 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildCashPayment() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            paymentWay = PaymentMethod.Cash.toString();
          });
        },
        child: Container(
          height: 15.h,
          decoration: paymentWay == PaymentMethod.Cash.toString()
              ? BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: [
                      0.3,
                      0.9,
                    ],
                    colors: [
                      Colors.green,
                      Colors.yellow,
                    ],
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(3.0.w)),
                )
              : BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(3.0.w)),
                ),
          child: Center(
            child: Text(
              "CASH",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            ),
          ),
        ),
      ),
    );
  }

  _buildAddressForm(BuildContext context) {
    _locationName.text='address';
    return Builder(builder: (context) {
      return Form(
        key: _formKey,
        child: Container(
          width: 90.0.w,
          padding: EdgeInsets.all(3.0.w),
          decoration:
              ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.shippingAddress.tr(),
                      style: Theme.of(context).textTheme.headline2),
                  SizedBoxFunctions.verticalSizedBox(2),
                  CustomTextFormField(
                      validator: (val) {
                        return AppValidation.validateSearch(val);
                      },
                      labelText: "${AppStrings.searchForLocation.tr()}*",
                      controller: _search),

                  SizedBoxFunctions.verticalSizedBox(2),
                  CustomTextFormField(
                    controller: _zoneNumber,
                    maxLength: 4,
                    keyBoardType: TextInputType.number,
                    labelText:"${AppStrings.zoneNumber.tr()}*",
                    validator: (value) {
                      return AppValidation.validateZone(value);
                    },
                  ),
                  SizedBoxFunctions.verticalSizedBox(2),
                  CustomTextFormField(
                    controller: _street,
                    keyBoardType: TextInputType.number,
                    maxLength: 4,
                    labelText: "${AppStrings.street.tr()}*",
                    validator: (value) {
                      return AppValidation.validateStreet(value);
                    },
                  ),
                  SizedBoxFunctions.verticalSizedBox(2),
                  CustomTextFormField(
                    controller: _buildingNumber,
                    keyBoardType: TextInputType.number,
                    maxLength: 4,
                    labelText: "${AppStrings.buildingNumber.tr()}*",
                    validator: (value) {
                      return AppValidation.validateBuildingNumber(value);
                    },
                  ),
                  SizedBoxFunctions.verticalSizedBox(2),
                  CustomTextFormField(
                    controller: _floor,
                    keyBoardType: TextInputType.number,
                    labelText: AppStrings.floor.tr(),
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBoxFunctions.verticalSizedBox(2),
                  CustomTextFormField(
                    controller: _apartment,
                    keyBoardType: TextInputType.number,
                    labelText: AppStrings.apartment.tr(),
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBoxFunctions.verticalSizedBox(2),
                  Visibility(visible: false,
                    child: CustomTextFormField(
                      controller: _locationName,
                      labelText: "Location Name",
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                  Visibility(visible: false,
                      child: SizedBoxFunctions.verticalSizedBox(2)),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  !tapped ?    BlocBuilder<LocationCubit,
                      StandardState<List<Prediction>>>(
                    bloc: locationCubit,
                    builder: (context, state) {
                      return state.when(
                        loading: () => Container(),
                        success: (data) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length >= 5 ? 5 : data.length,
                            itemBuilder: (context, index) {
                              final location = data[index];
                              return DecoratedBox(
                                decoration: ConstantBoxDecorationsAndShadows
                                        .RoundedBoxWithLightShadow
                                    .copyWith(borderRadius: BorderRadius.zero),
                                child: ListTile(
                                  title: Text(location.description ?? ''),
                                  onTap: () {
                                    setState(() {
                                      _search.text = location.description ?? '';
                                      tapped = true;
                                      placeDetailes(location.placeId ??'');
                                    });
                                    context
                                        .read<LocationCubit>()
                                        .hideSearchSuggestions();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        error: (networkExceptions) => SizedBox.shrink(),
                      );
                    },
                  ) :Container()
                ],
              )
            ],
          ),
        ),
      );
    });
  }

}
