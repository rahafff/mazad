import 'package:json_annotation/json_annotation.dart';

part 'update_password_body.g.dart';

@JsonSerializable()
class UpdatePasswordBody {
  @JsonKey(name: 'password')
  String? newPassword;
  @JsonKey(name: 'password_confirmation')
  String? passwordConfirmation;
  @JsonKey(name: 'old_password')
  String? oldPassword;
  UpdatePasswordBody(
      {required this.newPassword,
      required this.oldPassword,
      required this.passwordConfirmation});
  factory UpdatePasswordBody.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordBodyFromJson(json);
  Map<String, dynamic> toJson() => _$UpdatePasswordBodyToJson(this);
}
