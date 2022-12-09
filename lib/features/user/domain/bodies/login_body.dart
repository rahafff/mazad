import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable()
class LoginBody {
  @JsonKey(name: 'phone')
  String? phoneNumber;
  String? password;
  @JsonKey(name: 'fcm_token')
  String? fcmToken;
  LoginBody(
      {required this.password,
      required this.phoneNumber,
      required this.fcmToken});
  factory LoginBody.fromJson(Map<String, dynamic> json) =>
      _$LoginBodyFromJson(json);
  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}
