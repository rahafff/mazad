import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/app_validation_functions.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/app_functions.dart';
import 'package:elite_auction/core/widgets/back_button.dart';
import 'package:elite_auction/core/widgets/custom_text_form_field.dart';
import 'package:elite_auction/features/user/presentation/manager/update_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/widgets/loading_circular.dart';
import '../../../../core/widgets/sized_box_functions.dart';
import '../../domain/bodies/update_password_body.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  bool _isOldPasswordObscure = true;
  bool _isNewPasswordObscure = true;
  bool _isNewPasswordConfirmationObscure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _newPassword.dispose();
    _confirmNewPassword.dispose();
    _oldPassword.dispose();
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
            title: Text(AppStrings.changePasswordScreenTitle.tr()),
            leading: const BackButtonWidget(),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 10.0.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      authIcon: _isOldPasswordObscure
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      onPressingIcon: () {
                        setState(() {
                          _isOldPasswordObscure = !_isOldPasswordObscure;
                        });
                      },
                      controller: _oldPassword,
                      labelText: AppStrings.oldPassword.tr(),
                      validator: (String? value) {
                        return AppValidation.validateOldPassword(value);
                      },
                      obscureText: _isOldPasswordObscure,
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    CustomTextFormField(
                      authIcon: _isNewPasswordObscure
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      onPressingIcon: () {
                        setState(() {
                          _isNewPasswordObscure = !_isNewPasswordObscure;
                        });
                      },
                      controller: _newPassword,
                      labelText: AppStrings.newPassword.tr(),
                      validator: (String? value) {
                        return AppValidation.validateNewPassword(value);
                      },
                      obscureText: _isNewPasswordObscure,
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    CustomTextFormField(
                      authIcon: _isNewPasswordConfirmationObscure
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      onPressingIcon: () {
                        setState(() {
                          _isNewPasswordConfirmationObscure =
                              !_isNewPasswordConfirmationObscure;
                        });
                      },
                      controller: _confirmNewPassword,
                      labelText: AppStrings.confirmPassword.tr(),
                      validator: (String? value) {
                        return AppValidation
                            .validateConfirmPasswordInUpdatePasswordScreen(
                                value, _newPassword.text);
                      },
                      obscureText: _isNewPasswordConfirmationObscure,
                    ),
                    SizedBoxFunctions.verticalSizedBox(3),
                    _buildUpdatePasswordButtonBlocConsumer()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BlocConsumer<UpdatePasswordCubit, PostingState<EmptySuccessResponseEntity>>
      _buildUpdatePasswordButtonBlocConsumer() {
    return BlocConsumer<UpdatePasswordCubit,
        PostingState<EmptySuccessResponseEntity>>(
      listener: (context, state) {
        state.whenOrNull(
          success: (entity) {
            Navigator.pop(context);
            return Fluttertoast.showToast(
                msg: entity.message, toastLength: Toast.LENGTH_SHORT);
          },
          error: (NetworkExceptions error) => Fluttertoast.showToast(
              msg: NetworkExceptions.getErrorMessage(error),
              toastLength: Toast.LENGTH_SHORT),
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => LoadingCircularWidget(),
          orElse: () => ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<UpdatePasswordCubit>().emitUpdatePassword(
                      UpdatePasswordBody(
                          oldPassword: _oldPassword.text,
                          newPassword: _newPassword.text,
                          passwordConfirmation: _confirmNewPassword.text),
                    );
              }
            },
            child: Text(
              AppStrings.confirm.tr(),
            ),
          ),
        );
      },
    );
  }
}
