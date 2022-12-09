// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBody _$RegisterBodyFromJson(Map<String, dynamic> json) => RegisterBody(
      password: json['password'] as String,
      phoneNumber: json['phone'] as String,
      name: json['full_name'] as String,
      userId: json['user_uid'] as String?,
      tokenId: json['id_token'] as String?,
      confirmPassword: json['password_confirmation'] as String,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$RegisterBodyToJson(RegisterBody instance) =>
    <String, dynamic>{
      'phone': instance.phoneNumber,
      'password': instance.password,
      'password_confirmation': instance.confirmPassword,
      'full_name': instance.name,
      'user_uid': instance.userId,
      'id_token': instance.tokenId,
      'fcm_token': instance.fcmToken,
    };
