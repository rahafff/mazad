import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_product_details_entity.g.dart';

@JsonSerializable()
class MyProductDetailsEntity {
  MyProductDetailsEntity({
    this.productMainImage,
    this.subsubcategoryId,
    this.customerId,
    this.subcategoryId,
    this.productId,
    this.productQuantity,
    this.user,
    this.productPrice,
    this.customerPhone,
     this.productImages,
    this.productDetails,
    this.productStatus,
    this.subsubcategoryProduct,
    this.subcategoryProduct,
    this.expiredDate
  });
  @JsonKey(name: 'product_main_image')
  String? productMainImage;
  @JsonKey(name: 'subsubcategory_id')
  int? subsubcategoryId;
  @JsonKey(name: 'subcategory_id')
  int? subcategoryId;
  @JsonKey(name: 'customer_id')
  int? customerId;
  @JsonKey(name: 'product_quantity')
  int? productQuantity;
  @JsonKey(name: 'product_price')
  int? productPrice;
  @JsonKey(name: 'customer_phone')
  String? customerPhone;
  @JsonKey(name: 'product_details')
  List<ProductDetails>? productDetails;
  @JsonKey(name: 'product_status')
  ProductStatus? productStatus;
  @JsonKey(name: 'expired_date')
  String? expiredDate;
  @JsonKey(name: 'images')
  List<Images>? productImages;
  User? user;
  @JsonKey(name: 'id')
  int? productId;
  SubsubcategoryProduct? subsubcategoryProduct;
  SubcategoryProduct? subcategoryProduct;

  factory MyProductDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$MyProductDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MyProductDetailsEntityToJson(this);
}

@JsonSerializable()
class ProductStatus {
  ProductStatus({
    this.productStatusCode
  });
  @JsonKey(name: 'product_status_code')
  int? productStatusCode;

  factory ProductStatus.fromJson(Map<String, dynamic> json) =>
      _$ProductStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStatusToJson(this);
}


@JsonSerializable()
class SubsubcategoryProduct {
  SubsubcategoryProduct({
    this.subsubcategoryDetails
  });
    @JsonKey(name: 'subsubcategory_details')
   List<SubsubcategoryDetails>? subsubcategoryDetails;

  factory SubsubcategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$SubsubcategoryProductFromJson(json);

  Map<String, dynamic> toJson() => _$SubsubcategoryProductToJson(this);
}

@JsonSerializable()
class SubsubcategoryDetails {
  SubsubcategoryDetails({
    required this.subsubcategoryName
  });
  @JsonKey(name: 'subsubcategory_name')
  String subsubcategoryName;

  factory SubsubcategoryDetails.fromJson(Map<String, dynamic> json) =>
      _$SubsubcategoryDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SubsubcategoryDetailsToJson(this);
}

@JsonSerializable()
class SubcategoryProduct {
  SubcategoryProduct({
    this.subcategoryDetails
  });
  @JsonKey(name: 'subcategory_details')
  List<SubcategoryDetails>? subcategoryDetails;

  factory SubcategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryProductFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryProductToJson(this);
}

@JsonSerializable()
class SubcategoryDetails {
  SubcategoryDetails({
    required this.subcategoryName
  });
  @JsonKey(name: 'subcategory_name')
  String subcategoryName;

  factory SubcategoryDetails.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryDetailsToJson(this);
}


@JsonSerializable()
class Images {
  int? id;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "image_name")
  String? imageName;
  @JsonKey(name: "file_type")
  String? fileType;

  Images({
    this.id,
    this.productId,
    this.imageName,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}


@JsonSerializable()
class ProductDetails {
  ProductDetails({
    this.productDescription,
    this.productName,
    this.productId,
    this.productNote
  });
    @JsonKey(name: 'product_id')
   int? productId;
 @JsonKey(name: 'product_name')
 String? productName;
 @JsonKey(name: 'product_description')
   String? productDescription;
  @JsonKey(name: 'product_note')
   String? productNote;

  factory ProductDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}


@JsonSerializable()
class User {
  User({
    this.fullName
  });
  @JsonKey(name: 'full_name')
  String? fullName;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}


