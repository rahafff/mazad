// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_review_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReviewEntity _$UserReviewEntityFromJson(Map<String, dynamic> json) =>
    UserReviewEntity(
      reviewStars: json['review_stars'] as int,
      reviewDescription: json['review_description'] as String?,
      reviewStatus: json['review_status'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$UserReviewEntityToJson(UserReviewEntity instance) =>
    <String, dynamic>{
      'review_stars': instance.reviewStars,
      'review_description': instance.reviewDescription,
      'review_status': instance.reviewStatus,
      'created_at': instance.createdAt,
    };
