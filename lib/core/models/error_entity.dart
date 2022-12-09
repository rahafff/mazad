import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_entity.g.dart';

@JsonSerializable()
class ErrorEntity {
  bool? success;
  String? message;

  ErrorEntity({required this.success, required this.message});

  factory ErrorEntity.fromJson(Map<String, dynamic> json) =>
      _$ErrorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorEntityToJson(this);
}
