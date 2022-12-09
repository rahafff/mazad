import 'dart:io';

import 'package:dio/dio.dart';

class AddProductBody {
  final String productNameEn;
  final String productNameAr;
  final String? productDescriptionEn;
  final String? productDescriptionAr;
  final String? productPrice;
  final int? productQuantity;
  final String? phone;
  final int subcategoryId;
  final int? subsubcategoryId;
  final File mainImage;
  final File? firstOptionalImage;
  final File? secondOptionalImage;

  Future<Map<String, dynamic>> toMap() async {
    return {
      'translated_fields[1][product_name]': this.productNameEn,
      'translated_fields[2][product_name]': this.productNameAr,
      'translated_fields[1][product_description]': this.productDescriptionEn,
      'translated_fields[2][product_description]': this.productDescriptionAr,
      'product_price': this.productPrice,
      'product_quantity': this.productQuantity,
      'customer_phone': this.phone,
      'subcategory_id': this.subcategoryId,
      'subsubcategory_id': subsubcategoryId,
      'product_main_image': await MultipartFile.fromFile(mainImage.path),
      'product_additional_images[1][additional_image]':
          firstOptionalImage != null
              ? await MultipartFile.fromFile(firstOptionalImage!.path)
              : null,
      'product_additional_images[2][additional_image]':
          secondOptionalImage != null
              ? await MultipartFile.fromFile(secondOptionalImage!.path)
              : null
    };
  }

  const AddProductBody({
    required this.productNameEn,
    required this.productNameAr,
    this.productDescriptionEn,
    this.productDescriptionAr,
    this.productPrice,
    this.productQuantity,
    this.phone,
    required this.subcategoryId,
    this.subsubcategoryId,
    required this.mainImage,
    this.firstOptionalImage,
    this.secondOptionalImage,
  });
}
