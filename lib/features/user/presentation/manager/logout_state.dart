part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final String message;

  LogoutSuccess({
    required this.message,
  });
}

class LogoutError extends LogoutState {
  final String message;

  LogoutError({
    required this.message,
  });
}
