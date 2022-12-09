// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandardPaginationParams _$StandardPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    StandardPaginationParams(
      page: json['page'] as int?,
      perPage: json['per_page'],
      search: json['search'] as String?,
    );

Map<String, dynamic> _$StandardPaginationParamsToJson(
        StandardPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'search': instance.search,
      'per_page': instance.perPage,
    };
