// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationEntity<T> _$PaginationEntityFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationEntity<T>(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>)
          .map((e) => _$nullableGenericFromJson(e, fromJsonT))
          .toList(),
      lastPage: json['last_page'] as int?,
      perPage: json['per_page'],
    );

Map<String, dynamic> _$PaginationEntityToJson<T>(
  PaginationEntity<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data
          .map((e) => _$nullableGenericToJson(e, toJsonT))
          .toList(),
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
