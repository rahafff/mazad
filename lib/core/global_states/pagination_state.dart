import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/network_exceptions.dart';

part 'pagination_state.freezed.dart';

@freezed
class PaginationState<T> with _$PaginationState<T> {
  const factory PaginationState.loading() = Loading<T>;

  const factory PaginationState.success(List<T?> data, int currentPage) =
      Success<T>;

  const factory PaginationState.error(NetworkExceptions networkExceptions) =
      Error<T>;
}
