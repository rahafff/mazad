import 'package:freezed_annotation/freezed_annotation.dart';

part 'empty_success_response_entity.g.dart';

@JsonSerializable()
class EmptySuccessResponseEntity {
  bool success;
  String message;

  EmptySuccessResponseEntity({required this.success, required this.message});

  factory EmptySuccessResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$EmptySuccessResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EmptySuccessResponseEntityToJson(this);
}
