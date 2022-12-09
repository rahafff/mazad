import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/network_exceptions.dart';

part 'posting_state.freezed.dart';

@freezed
class PostingState<T> with _$PostingState<T> {
  const factory PostingState.idle() = Idle<T>;

  const factory PostingState.loading() = Loading<T>;

  const factory PostingState.success(T data) = Success<T>;

  const factory PostingState.error(NetworkExceptions networkExceptions) =
      Error<T>;
}
