import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable()
class RegisterBody {
  @JsonKey(name: 'phone')
  String phoneNumber;
  String password;
  @JsonKey(name: 'password_confirmation')
  String confirmPassword;
  @JsonKey(name: 'full_name')
  String name;
  @JsonKey(name: 'user_uid')
  String? userId;
  @JsonKey(name: 'id_token')
  String? tokenId;
  @JsonKey(name: 'fcm_token')
  String? fcmToken;
  RegisterBody(
      {required this.password,
      required this.phoneNumber,
      required this.name,
      required this.userId,
      required this.tokenId,
      required this.confirmPassword,
      required this.fcmToken});
  factory RegisterBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterBodyFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterBodyToJson(this);
}
