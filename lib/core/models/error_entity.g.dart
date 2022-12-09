// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorEntity _$ErrorEntityFromJson(Map<String, dynamic> json) => ErrorEntity(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ErrorEntityToJson(ErrorEntity instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
