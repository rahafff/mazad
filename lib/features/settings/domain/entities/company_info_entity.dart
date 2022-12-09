import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_info_entity.g.dart';

@JsonSerializable()
class CompanyInfoEntity {
  CompanyInfoEntity({
    required this.companyInfo,
  });
  @JsonKey(name: 'company_info')
  CompanyInfo companyInfo;

  factory CompanyInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$CompanyInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyInfoEntityToJson(this);
}

@JsonSerializable()
class CompanyInfo {
  CompanyInfo({
    required this.address,
    required this.email,
    required this.phone,
  });
  String address;
  String email;
  String phone;
  factory CompanyInfo.fromJson(Map<String, dynamic> json) =>
      _$CompanyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyInfoToJson(this);
}
