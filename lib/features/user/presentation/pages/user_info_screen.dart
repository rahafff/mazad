import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/app_validation_functions.dart';
import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:elite_auction/core/widgets/custom_text_form_field.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:elite_auction/features/user/domain/bodies/update_user_address_body.dart';
import 'package:elite_auction/features/user/domain/bodies/update_user_info_body.dart';
import 'package:elite_auction/features/user/presentation/manager/update_user_address_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/update_user_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/loading_circular.dart';

class MyProfileScreen extends StatelessWidget {
  final TextEditingController _name =
      TextEditingController(text: AppSharedPreferences.accessName ?? '');
  final TextEditingController _zoneNumber =
      TextEditingController(text: AppSharedPreferences.zoneNumber ?? '');
  final TextEditingController _street =
      TextEditingController(text: AppSharedPreferences.street ?? '');
  final TextEditingController _buildingNumber =
      TextEditingController(text: AppSharedPreferences.buildingNumber ?? '');

  final GlobalKey<FormState> _formKeyForPersonalInfo = GlobalKey();
  final GlobalKey<FormState> _formKeyForAddress = GlobalKey();

  MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.myProf.tr(),
            ),
            leading: const BackButtonWidget(),
          ),
          body: Container(
            height: 100.0.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.center,
                image: AssetImage(ImageAssetsManager.userInfoBackground),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildUserInfoForm(context),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, Routes.updatePasswordRoute),
                    child: Text(
                      AppStrings.changePasswordScreenTitle.tr(),
                    ),
                  ),
                  buildAddressForm(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form buildUserInfoForm(BuildContext context) {
    return Form(
      key: _formKeyForPersonalInfo,
      child: Container(
        decoration: ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 5.w),
        margin: EdgeInsets.only(
            top: 5.0.h, bottom: 2.0.h, left: 5.0.w, right: 5.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppStrings.personalInfo.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBoxFunctions.verticalSizedBox(2),
            CustomTextFormField(
              authIcon: Icons.person,
              labelText: AppStrings.fullName.tr(),
              controller: _name,
              validator: (value) {
                return AppValidation.validateName(value);
              },
            ),
            SizedBoxFunctions.verticalSizedBox(2),
            buildSavePersonalInfoConsumer(context),
          ],
        ),
      ),
    );
  }

  buildSavePersonalInfoConsumer(BuildContext context) {
    return BlocConsumer<UpdateUserInfoCubit,
        PostingState<EmptySuccessResponseEntity>>(
      listener: (ctx, state) {
        state.whenOrNull(
          success: (entity) {
            return Fluttertoast.showToast(
                msg: entity.message, toastLength: Toast.LENGTH_SHORT);
          },
          error: (NetworkExceptions error) => Fluttertoast.showToast(
              msg: NetworkExceptions.getErrorMessage(error),
              toastLength: Toast.LENGTH_SHORT),
        );
      },
      builder: (ctx, state) {
        return state.maybeWhen(
          loading: () => LoadingCircularWidget(),
          orElse: () => TextButton(
            onPressed: () {
              if (_formKeyForPersonalInfo.currentState!.validate()) {
                AppSharedPreferences.accessName = _name.text;
                context
                    .read<UpdateUserInfoCubit>()
                    .emitUpdateUserInfo(UpdateUserInfoBody(name: _name.text));
              }
            },
            style: TextButton.styleFrom(backgroundColor: ColorManager.kGreen),
            child: Text(
              AppStrings.save.tr(),
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: ColorManager.kWhite),
            ),
          ),
        );
      },
    );
  }

  Form buildAddressForm(BuildContext context) {
    return Form(
      key: _formKeyForAddress,
      child: Container(
        decoration: ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 5.w),
        margin: EdgeInsets.only(
            top: 2.0.h, bottom: 5.0.h, left: 5.0.w, right: 5.0.w),
        child: Column(
          children: [
            Text(
              AppStrings.address.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBoxFunctions.verticalSizedBox(2),
            CustomTextFormField(
              authIcon: FontAwesomeIcons.flag,
              controller: _zoneNumber,
              keyBoardType: TextInputType.number,
              maxLength: 4,
              labelText: AppStrings.zoneNumber.tr(),
              validator: (value) {
                return AppValidation.validateZone(value);
              },
            ),
            SizedBoxFunctions.verticalSizedBox(2),
            CustomTextFormField(
              controller: _street,
              authIcon: FontAwesomeIcons.road,
              keyBoardType: TextInputType.number,
              maxLength: 4,
              labelText: AppStrings.street.tr(),
              validator: (value) {
                return AppValidation.validateStreet(value);
              },
            ),
            SizedBoxFunctions.verticalSizedBox(2),
            CustomTextFormField(
              authIcon: Icons.home,
              controller: _buildingNumber,
              keyBoardType: TextInputType.number,
              maxLength: 4,
              labelText: AppStrings.buildingNumber.tr(),
              validator: (value) {
                return AppValidation.validateBuildingNumber(value);
              },
            ),
            SizedBoxFunctions.verticalSizedBox(2),
            buildSaveAddressConsumer(context),
          ],
        ),
      ),
    );
  }

  buildSaveAddressConsumer(BuildContext context) {
    return BlocConsumer<UpdateUserAddressCubit,
        PostingState<EmptySuccessResponseEntity>>(
      listener: (ctx, state) {
        state.whenOrNull(
          success: (entity) {
            return Fluttertoast.showToast(
                msg: entity.message, toastLength: Toast.LENGTH_SHORT);
          },
          error: (NetworkExceptions error) => Fluttertoast.showToast(
              msg: NetworkExceptions.getErrorMessage(error),
              toastLength: Toast.LENGTH_SHORT),
        );
      },
      builder: (ctx, state) {
        return state.maybeWhen(
          loading: () => LoadingCircularWidget(),
          orElse: () => TextButton(
            onPressed: () {
              if (_formKeyForAddress.currentState!.validate()) {
                AppSharedPreferences.buildingNumber = _buildingNumber.text;
                AppSharedPreferences.zoneNumber = _zoneNumber.text;
                AppSharedPreferences.street = _street.text;
                context.read<UpdateUserAddressCubit>().emitUpdateUserAddress(
                      UpdateUserAddressBody(
                        buildingNumber: _buildingNumber.text.toString(),
                        zoneNumber: _zoneNumber.text.toString(),
                        street: _street.text,
                      ),
                    );
              }
            },
            style: TextButton.styleFrom(backgroundColor: ColorManager.kGreen),
            child: Text(
              AppStrings.save.tr(),
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(color: ColorManager.kWhite),
            ),
          ),
        );
      },
    );
  }
}
