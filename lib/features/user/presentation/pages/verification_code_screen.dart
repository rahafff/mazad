import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/resources/app_validation_functions.dart';
import 'package:elite_auction/core/resources/bottom_navigation_bar_Items_Ids.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/core/widgets/app_functions.dart';
import 'package:elite_auction/core/widgets/time_card.dart';
import 'package:elite_auction/features/app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/register_cubit.dart';
import 'package:elite_auction/features/user/presentation/manager/verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/models/base_entity.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/loading_circular.dart';
import '../../../../core/widgets/sized_box_functions.dart';
import '../../domain/bodies/register_body.dart';
import '../../domain/entities/user_entity.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isCountingDown = true;
  late Timer _timer;
  final GlobalKey<FormState> _formKey = GlobalKey();
  static const _countDownDuration = 60;
  int _seconds = _countDownDuration;

  @override
  void initState() {
    context
        .read<VerificationCubit>()
        .emitSendCode(context.read<RegisterCubit>().registerParams.phoneNumber);
    startTimer();
    super.initState();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (_seconds > 1) {
          setState(
            () {
              _seconds--;
            },
          );
        } else {
          _timer.cancel();
          setState(
            () {
              _isCountingDown = false;
              _seconds = _countDownDuration;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<RegisterCubit>().registerParams;

    return BlocListener<VerificationCubit, VerificationState>(
      listener: (context, state) {
        if (state is VerificationError) {
          Fluttertoast.showToast(
              msg: NetworkExceptions.getErrorMessage(state.exception),
              toastLength: Toast.LENGTH_SHORT);
        }
      },
      child: GestureDetector(
        onTap: () {
          AppFunctions.unfocus(context);
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Image.asset(
                ImageAssetsManager.eliteWords,
                width: 50.w,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: 100.0.h,
                padding:
                    EdgeInsets.only(right: 5.0.w, left: 5.0.w, bottom: 15.h),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ImageAssetsManager.backgroundForForms),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.verificationCodePageTitle.tr(),
                        style: Theme.of(context).textTheme.headline1),
                    SizedBoxFunctions.verticalSizedBox(2),
                    Text(
                      AppStrings.verificationCodePageHeader.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: ColorManager.kMove),
                      textAlign: TextAlign.center,
                    ),
                    SizedBoxFunctions.verticalSizedBox(5),
                    Form(
                      key: _formKey,
                      child: CustomTextFormField(
                        controller: _otpController,
                        labelText: AppStrings.code.tr(),
                        authIcon: Icons.qr_code,
                        validator: (value) {
                          return AppValidation.validateVerificationCode(value);
                        },
                        keyBoardType: TextInputType.number,
                      ),
                    ),
                    SizedBoxFunctions.verticalSizedBox(5),
                    _buildVerifyButtonBlocConsumer(user),
                    SizedBoxFunctions.verticalSizedBox(3),
                    _isCountingDown
                        ? TimeCard(time: _seconds.toString())
                        : _buildResendCode(context, user),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildResendCode(BuildContext context, RegisterBody user) {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(msg: AppStrings.weHaveSentVerCode.tr());
        context.read<VerificationCubit>().emitSendCode(user.phoneNumber);
        _isCountingDown = true;
        startTimer();
      },
      child: Text(
        AppStrings.resendCode.tr(),
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: ColorManager.kMove,
            ),
      ),
    );
  }

  BlocConsumer<VerificationCubit, VerificationState>
      _buildVerifyButtonBlocConsumer(RegisterBody user) {
    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (context, state) {
        if (state is VerificationOtpVerified) {
          context.read<RegisterCubit>().emitRegister(
                RegisterBody(
                    name: user.name,
                    phoneNumber: user.phoneNumber,
                    tokenId: AppSharedPreferences.accessTokenFirebase,
                    confirmPassword: user.confirmPassword,
                    password: user.password,
                    userId: AppSharedPreferences.accessUuid,
                    fcmToken: AppSharedPreferences.fcmToken),
              );
        }
      },
      builder: (context, state) {
        if (state is VerificationLoading) {
          return LoadingCircularWidget();
        }
        return BlocConsumer<RegisterCubit,
            PostingState<BaseEntity<UserEntity>>>(
          listener: (ctx, state) {
            state.whenOrNull(
              error: (NetworkExceptions networkExceptions) {
                return Fluttertoast.showToast(
                    msg: NetworkExceptions.getErrorMessage(networkExceptions),
                    toastLength: Toast.LENGTH_SHORT);
              },
              success: (state) {
                context
                    .read<AppBottomNavigationBarIndexChangerCubit>()
                    .changeScreen(homeId);
                Navigator.pop(context);
                return Fluttertoast.showToast(
                    msg: state.message.toString(),
                    toastLength: Toast.LENGTH_SHORT);
              },
            );
          },
          builder: (ctx, state) {
            return state.maybeWhen(
              orElse: () {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<VerificationCubit>()
                          .emitVerifyOtp(_otpController.text);
                    }
                  },
                  child: Text(AppStrings.done.tr()),
                );
              },
              loading: () {
                return LoadingCircularWidget();
              },
            );
          },
        );
      },
    );
  }
}
