import 'package:json_annotation/json_annotation.dart';

part 'standard_pagination_params.g.dart';

@JsonSerializable()
class StandardPaginationParams {
  int? page;
  String? search;
  @JsonKey(name: "per_page")
  dynamic perPage;

  StandardPaginationParams({
    required this.page,
    this.perPage,
    this.search,
  });
  factory StandardPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$StandardPaginationParamsFromJson(json);
  Map<String, dynamic> toJson() => _$StandardPaginationParamsToJson(this);
}
