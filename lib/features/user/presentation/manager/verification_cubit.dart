import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../domain/repositories/user_repository.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final UserRepository _userRepository;

  VerificationCubit(this._userRepository) : super(VerificationInitial());

  void emitSendCode(String phoneNumber) async {
    var result = await _userRepository.sendCode(phoneNumber);
    result.when(success: (_) {
      emit(VerificationPhoneSubmitted());
    }, failure: (NetworkExceptions networkExceptions) {
      emit(VerificationError(exception: networkExceptions));
    });
  }

  void emitVerifyOtp(String otp) async {
    emit(VerificationLoading());
    var result = await _userRepository.verifyOtp(otp);
    result.when(success: (_) {
      emit(VerificationOtpVerified());
    }, failure: (NetworkExceptions networkExceptions) {
      emit(VerificationError(exception: networkExceptions));
    });
  }
}
