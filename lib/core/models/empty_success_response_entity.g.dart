// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_success_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptySuccessResponseEntity _$EmptySuccessResponseEntityFromJson(
        Map<String, dynamic> json) =>
    EmptySuccessResponseEntity(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$EmptySuccessResponseEntityToJson(
        EmptySuccessResponseEntity instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
