// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordBody _$UpdatePasswordBodyFromJson(Map<String, dynamic> json) =>
    UpdatePasswordBody(
      newPassword: json['password'] as String?,
      oldPassword: json['old_password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
    );

Map<String, dynamic> _$UpdatePasswordBodyToJson(UpdatePasswordBody instance) =>
    <String, dynamic>{
      'password': instance.newPassword,
      'password_confirmation': instance.passwordConfirmation,
      'old_password': instance.oldPassword,
    };
