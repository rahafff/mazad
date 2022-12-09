import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  UserEntity({
    this.token,
    this.user,
    this.adminRole,
  });
  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
  String? token;
  User? user;
  @JsonKey(name: "admin_role")
  String? adminRole;
}

@JsonSerializable()
class User {
  User({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.isVerified,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.stripeId,
    this.pmType,
    this.pmLastFour,
    this.trialEndsAt,
    this.userUid,
  });

  int? id;
  @JsonKey(name: "full_name")
  String? fullName;
  String? email;
  String? phone;
  @JsonKey(name: "is_verified")
  int? isVerified;
  @JsonKey(name: "fcm_token")
  String? fcmToken;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "stripe_id")
  String? stripeId;
  @JsonKey(name: "pm_type")
  String? pmType;
  @JsonKey(name: "pm_last_four")
  String? pmLastFour;
  @JsonKey(name: "trial_ends_at")
  String? trialEndsAt;
  @JsonKey(name: "user_uid")
  String? userUid;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
