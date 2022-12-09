import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_entity.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: false)
class BaseEntity<T> {
  BaseEntity({
    required this.success,
    required this.data,
    this.message,
  });

  factory BaseEntity.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$BaseEntityFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseEntityToJson(this, toJsonT);
  bool success;
  T? data;
  String? message;
}
