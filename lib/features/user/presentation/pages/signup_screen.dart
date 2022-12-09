import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/app_validation_functions.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/app_functions.dart';
import 'package:elite_auction/features/user/presentation/manager/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/constant_box_decorations_and_shadows.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/sized_box_functions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  String? _countryCode;
  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _name.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phone.dispose();
    super.dispose();
  }

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
              padding: EdgeInsets.only(bottom: 10.0.h, left: 5.w, right: 5.w),
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
                    Text(AppStrings.register.tr(),
                        style: Theme.of(context).textTheme.headline1),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    CustomTextFormField(
                      controller: _name,
                      authIcon: Icons.person,
                      labelText: AppStrings.fullName.tr(),
                      validator: (value) {
                        return AppValidation.validateName(value);
                      },
                    ),
                    CountryCodePicker(
                      onChanged: (code) {
                        _countryCode = code.dialCode;
                        _phone.text = _countryCode ?? "";
                      },
                      hideMainText: true,
                      showFlagMain: true,
                      showFlag: false,
                      flagWidth: 10.0.w,
                      initialSelection: 'QA',
                      hideSearch: false,
                      showCountryOnly: false,
                      boxDecoration: const BoxDecoration(
                          color: Colors.transparent,
                          border: Border.fromBorderSide(BorderSide.none)),
                      showOnlyCountryWhenClosed: false,
                      onInit: (code) {
                        _countryCode = code?.dialCode;
                        _phone.text = _countryCode ?? "";
                      },
                      flagDecoration: BoxDecoration(
                        boxShadow: [
                          ConstantBoxDecorationsAndShadows.darkShadow
                        ],
                      ),
                      searchDecoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorManager.kMove,
                        ),
                      ),
                    ),
                    CustomTextFormField(
                      controller: _phone,
                      labelText: AppStrings.phone.tr(),
                      authIcon: Icons.phone,
                      validator: (value) {
                        return AppValidation.validatePhoneNumber(value);
                      },
                      keyBoardType: TextInputType.phone,
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    CustomTextFormField(
                      controller: _password,
                      labelText: AppStrings.password.tr(),
                      authIcon: _isPasswordObscure
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      onPressingIcon: () {
                        setState(() {
                          _isPasswordObscure = !_isPasswordObscure;
                        });
                      },
                      validator: (value) {
                        return AppValidation.validatePassword(value);
                      },
                      obscureText: _isPasswordObscure,
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    CustomTextFormField(
                      controller: _confirmPassword,
                      onPressingIcon: () {
                        setState(() {
                          _isConfirmPasswordObscure =
                              !_isConfirmPasswordObscure;
                        });
                      },
                      authIcon: _isConfirmPasswordObscure
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      labelText: AppStrings.confirmPassword.tr(),
                      validator: (value) {
                        return AppValidation
                            .validatePasswordConfirmationInRegisterScreen(
                                value, _password.text);
                      },
                      obscureText: _isConfirmPasswordObscure,
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RegisterCubit>().setRegisterParams(
                              name: _name.text,
                              phoneNumber: _phone.text,
                              password: _password.text,
                              confirmPassword: _confirmPassword.text);
                          Navigator.pushReplacementNamed(
                              context, Routes.registerLoadingRoute);
                        }
                      },
                      child: Text(
                        AppStrings.next.tr(),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${AppStrings.alrdyHaveAcc.tr()} ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: ColorManager.kMove)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute);
                          },
                          child: Text(
                            AppStrings.login.tr(),
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: ColorManager.kMove,
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                      ],
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
