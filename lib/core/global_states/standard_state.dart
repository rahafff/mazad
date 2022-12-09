import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/network_exceptions.dart';

part 'standard_state.freezed.dart';

/// a standard state contains the well known states like loading , error , success which can be used globally
@freezed
class StandardState<T> with _$StandardState<T> {
  const factory StandardState.loading() = Loading<T>;

  const factory StandardState.success(T data) = Success<T>;

  const factory StandardState.error(NetworkExceptions networkExceptions) =
      Error<T>;
}
