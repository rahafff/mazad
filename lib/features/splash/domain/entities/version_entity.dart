import 'package:freezed_annotation/freezed_annotation.dart';

part 'version_entity.g.dart';

@JsonSerializable()
class VersionEntity {
  @JsonKey(name: 'android_version')
  final String androidVersion;
  @JsonKey(name: 'android_build_number')
  final String androidBuildNumber;
  @JsonKey(name: 'ios_version')
  final String iosVersion;
  @JsonKey(name: 'ios_build_number')
  final String iosBuildNumber;

  const VersionEntity({
    required this.androidVersion,
    required this.androidBuildNumber,
    required this.iosVersion,
    required this.iosBuildNumber,
  });

  factory VersionEntity.fromJson(Map<String, dynamic> json) =>
      _$VersionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VersionEntityToJson(this);
}
