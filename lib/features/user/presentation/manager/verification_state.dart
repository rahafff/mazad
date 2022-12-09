part of 'verification_cubit.dart';

@immutable
abstract class VerificationState {}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationError extends VerificationState {
  final NetworkExceptions exception;

  VerificationError({
    required this.exception,
  });
}

class VerificationPhoneSubmitted extends VerificationState {}

class VerificationOtpVerified extends VerificationState {}
