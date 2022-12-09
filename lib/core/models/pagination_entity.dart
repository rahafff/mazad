import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_entity.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationEntity<T> {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<T?> data;
  @JsonKey(name: "last_page")
  int? lastPage;
  @JsonKey(name: "per_page")
  dynamic perPage;

  PaginationEntity({
    this.currentPage,
    required this.data,
    this.lastPage,
    this.perPage,
  });
  factory PaginationEntity.fromJson(
    dynamic json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$PaginationEntityFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginationEntityToJson(this, toJsonT);
}
