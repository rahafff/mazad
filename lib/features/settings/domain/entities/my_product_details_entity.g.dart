// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_product_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProductDetailsEntity _$MyProductDetailsEntityFromJson(
        Map<String, dynamic> json) =>
    MyProductDetailsEntity(
      productMainImage: json['product_main_image'] as String?,
      subsubcategoryId: json['subsubcategory_id'] as int?,
      customerId: json['customer_id'] as int?,
      subcategoryId: json['subcategory_id'] as int?,
      productId: json['id'] as int?,
      productQuantity: json['product_quantity'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      productPrice: json['product_price'] as int?,
      customerPhone: json['customer_phone'] as String?,
      productImages: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      productDetails: (json['product_details'] as List<dynamic>?)
          ?.map((e) => ProductDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      productStatus: json['product_status'] == null
          ? null
          : ProductStatus.fromJson(
              json['product_status'] as Map<String, dynamic>),
      subsubcategoryProduct: json['subsubcategoryProduct'] == null
          ? null
          : SubsubcategoryProduct.fromJson(
              json['subsubcategoryProduct'] as Map<String, dynamic>),
      subcategoryProduct: json['subcategoryProduct'] == null
          ? null
          : SubcategoryProduct.fromJson(
              json['subcategoryProduct'] as Map<String, dynamic>),
      expiredDate: json['expired_date'] as String?,
    );

Map<String, dynamic> _$MyProductDetailsEntityToJson(
        MyProductDetailsEntity instance) =>
    <String, dynamic>{
      'product_main_image': instance.productMainImage,
      'subsubcategory_id': instance.subsubcategoryId,
      'subcategory_id': instance.subcategoryId,
      'customer_id': instance.customerId,
      'product_quantity': instance.productQuantity,
      'product_price': instance.productPrice,
      'customer_phone': instance.customerPhone,
      'product_details': instance.productDetails,
      'product_status': instance.productStatus,
      'expired_date': instance.expiredDate,
      'images': instance.productImages,
      'user': instance.user,
      'id': instance.productId,
      'subsubcategoryProduct': instance.subsubcategoryProduct,
      'subcategoryProduct': instance.subcategoryProduct,
    };

ProductStatus _$ProductStatusFromJson(Map<String, dynamic> json) =>
    ProductStatus(
      productStatusCode: json['product_status_code'] as int?,
    );

Map<String, dynamic> _$ProductStatusToJson(ProductStatus instance) =>
    <String, dynamic>{
      'product_status_code': instance.productStatusCode,
    };

SubsubcategoryProduct _$SubsubcategoryProductFromJson(
        Map<String, dynamic> json) =>
    SubsubcategoryProduct(
      subsubcategoryDetails: (json['subsubcategory_details'] as List<dynamic>?)
          ?.map(
              (e) => SubsubcategoryDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubsubcategoryProductToJson(
        SubsubcategoryProduct instance) =>
    <String, dynamic>{
      'subsubcategory_details': instance.subsubcategoryDetails,
    };

SubsubcategoryDetails _$SubsubcategoryDetailsFromJson(
        Map<String, dynamic> json) =>
    SubsubcategoryDetails(
      subsubcategoryName: json['subsubcategory_name'] as String,
    );

Map<String, dynamic> _$SubsubcategoryDetailsToJson(
        SubsubcategoryDetails instance) =>
    <String, dynamic>{
      'subsubcategory_name': instance.subsubcategoryName,
    };

SubcategoryProduct _$SubcategoryProductFromJson(Map<String, dynamic> json) =>
    SubcategoryProduct(
      subcategoryDetails: (json['subcategory_details'] as List<dynamic>?)
          ?.map((e) => SubcategoryDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubcategoryProductToJson(SubcategoryProduct instance) =>
    <String, dynamic>{
      'subcategory_details': instance.subcategoryDetails,
    };

SubcategoryDetails _$SubcategoryDetailsFromJson(Map<String, dynamic> json) =>
    SubcategoryDetails(
      subcategoryName: json['subcategory_name'] as String,
    );

Map<String, dynamic> _$SubcategoryDetailsToJson(SubcategoryDetails instance) =>
    <String, dynamic>{
      'subcategory_name': instance.subcategoryName,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      imageName: json['image_name'] as String?,
    )..fileType = json['file_type'] as String?;

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'image_name': instance.imageName,
      'file_type': instance.fileType,
    };

ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) =>
    ProductDetails(
      productDescription: json['product_description'] as String?,
      productName: json['product_name'] as String?,
      productId: json['product_id'] as int?,
      productNote: json['product_note'] as String?,
    );

Map<String, dynamic> _$ProductDetailsToJson(ProductDetails instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name': instance.productName,
      'product_description': instance.productDescription,
      'product_note': instance.productNote,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      fullName: json['full_name'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'full_name': instance.fullName,
    };
