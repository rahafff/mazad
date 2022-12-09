import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_review_entity.g.dart';

@JsonSerializable()
class UserReviewEntity {
  @JsonKey(name: 'review_stars')
  final int reviewStars;
  @JsonKey(name: 'review_description')
  final String? reviewDescription;
  @JsonKey(name: 'review_status')
  final String reviewStatus;
  @JsonKey(name: 'created_at')
  final String createdAt;

  Map<String, dynamic> toJson() => _$UserReviewEntityToJson(this);
  factory UserReviewEntity.fromJson(Map<String, dynamic> json) =>
      _$UserReviewEntityFromJson(json);

  const UserReviewEntity({
    required this.reviewStars,
    this.reviewDescription,
    required this.reviewStatus,
    required this.createdAt,
  });
}
