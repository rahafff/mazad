// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      adminRole: json['admin_role'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
      'admin_role': instance.adminRole,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      isVerified: json['is_verified'] as int?,
      fcmToken: json['fcm_token'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      stripeId: json['stripe_id'] as String?,
      pmType: json['pm_type'] as String?,
      pmLastFour: json['pm_last_four'] as String?,
      trialEndsAt: json['trial_ends_at'] as String?,
      userUid: json['user_uid'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'is_verified': instance.isVerified,
      'fcm_token': instance.fcmToken,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'stripe_id': instance.stripeId,
      'pm_type': instance.pmType,
      'pm_last_four': instance.pmLastFour,
      'trial_ends_at': instance.trialEndsAt,
      'user_uid': instance.userUid,
    };
