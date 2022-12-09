import 'package:json_annotation/json_annotation.dart';

part 'update_user_info_body.g.dart';

@JsonSerializable()
class UpdateUserInfoBody {
  @JsonKey(name: 'full_name')
  String name;
  UpdateUserInfoBody({
    required this.name,
  });
  factory UpdateUserInfoBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserInfoBodyFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserInfoBodyToJson(this);
}
