// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionEntity _$VersionEntityFromJson(Map<String, dynamic> json) =>
    VersionEntity(
      androidVersion: json['android_version'] as String,
      androidBuildNumber: json['android_build_number'] as String,
      iosVersion: json['ios_version'] as String,
      iosBuildNumber: json['ios_build_number'] as String,
    );

Map<String, dynamic> _$VersionEntityToJson(VersionEntity instance) =>
    <String, dynamic>{
      'android_version': instance.androidVersion,
      'android_build_number': instance.androidBuildNumber,
      'ios_version': instance.iosVersion,
      'ios_build_number': instance.iosBuildNumber,
    };
