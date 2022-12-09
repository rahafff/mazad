import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/resources/app_validation_functions.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/bottom_navigation_bar_Items_Ids.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/widgets/app_functions.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:elite_auction/core/widgets/custom_text_form_field.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import 'package:elite_auction/features/user/domain/entities/user_entity.dart';
import 'package:elite_auction/features/user/presentation/manager/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/sized_box_functions.dart';
import '../../domain/bodies/login_body.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isObscure = true;
  String? _countryCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFunctions.unfocus(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(ImageAssetsManager.eliteWords, width: 50.w),
            leading: const BackButtonWidget(),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 100.h,
              padding: EdgeInsets.only(right: 5.0.w, left: 5.0.w, bottom: 15.h),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageAssetsManager.backgroundForForms),
                    fit: BoxFit.cover),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        AppStrings.login.tr(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    CountryCodePicker(
                      onChanged: (code) {
                        _countryCode = code.dialCode;
                        _phone.text = _countryCode!;
                      },
                      hideMainText: true,
                      showFlagMain: true,
                      showFlag: false,
                      initialSelection: 'QA',
                      hideSearch: false,
                      flagWidth: 10.0.w,
                      showCountryOnly: false,
                      backgroundColor: ColorManager.kWhite,
                      showOnlyCountryWhenClosed: false,
                      onInit: (code) {
                        _countryCode = code?.dialCode;
                        _phone.text = _countryCode ?? "";
                      },
                      flagDecoration: BoxDecoration(boxShadow: [
                        ConstantBoxDecorationsAndShadows.darkShadow
                      ]),
                      searchDecoration: const InputDecoration(
                          prefixIcon: Icon(
                        Icons.search,
                        color: ColorManager.kMove,
                      )),
                    ),
                    CustomTextFormField(
                      controller: _phone,
                      authIcon: Icons.phone,
                      labelText: AppStrings.phone.tr(),
                      validator: (value) {
                        return AppValidation.validatePhoneNumber(value);
                      },
                      keyBoardType: TextInputType.phone,
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    CustomTextFormField(
                      controller: _password,
                      authIcon: _isObscure
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      onPressingIcon: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      labelText: AppStrings.password.tr(),
                      validator: (String? value) {
                        return AppValidation.validatePassword(value);
                      },
                      obscureText: _isObscure,
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    BlocConsumer<LoginCubit,
                        PostingState<BaseEntity<UserEntity>>>(
                      listener: (context, state) {
                        state.whenOrNull(
                            success: (BaseEntity<UserEntity> entity) {
                              context
                                  .read<
                                      AppBottomNavigationBarIndexChangerCubit>()
                                  .changeScreen(homeId);
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: entity.message.toString(),
                                  toastLength: Toast.LENGTH_SHORT);
                            },
                            error: (NetworkExceptions error) =>
                                Fluttertoast.showToast(
                                    msg: NetworkExceptions.getErrorMessage(
                                        error),
                                    toastLength: Toast.LENGTH_SHORT));
                      },
                      builder: (context,
                          PostingState<BaseEntity<UserEntity>> state) {
                        return state.maybeWhen(
                          loading: () => LoadingCircularWidget(),
                          orElse: () => ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().emitLogin(
                                      LoginBody(
                                          password: _password.text,
                                          fcmToken:
                                              AppSharedPreferences.fcmToken,
                                          phoneNumber: _phone.text),
                                    );
                              }
                            },
                            child: Text(AppStrings.done.tr()),
                          ),
                        );
                      },
                    ),
                    SizedBoxFunctions.verticalSizedBox(2),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.registerRoute);
                      },
                      child: Text(
                        AppStrings.register.tr(),
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: ColorManager.kMove,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
