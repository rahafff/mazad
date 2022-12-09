// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyInfoEntity _$CompanyInfoEntityFromJson(Map<String, dynamic> json) =>
    CompanyInfoEntity(
      companyInfo:
          CompanyInfo.fromJson(json['company_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyInfoEntityToJson(CompanyInfoEntity instance) =>
    <String, dynamic>{
      'company_info': instance.companyInfo,
    };

CompanyInfo _$CompanyInfoFromJson(Map<String, dynamic> json) => CompanyInfo(
      address: json['address'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$CompanyInfoToJson(CompanyInfo instance) =>
    <String, dynamic>{
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
    };
