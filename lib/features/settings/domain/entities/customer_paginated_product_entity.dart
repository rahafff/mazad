class CustomerPaginatedProductEntity {
  CustomerPaginatedProductEntity(
      {required this.id,
      required this.customerId,
      required this.productStatusId,
      required this.productMainImage,
      required this.productPrice,
      required this.customerPhone,
      required this.productDetails,
      required this.productStatus,
      required this.user,
      required this.expireDate});
  late final int id;
  late final int customerId;
  late final int productStatusId;
  late final String productMainImage;
  late final int productPrice;
  late final String customerPhone;
  late final List<ProductDetails> productDetails;
  late final ProductStatus productStatus;
  late final User user;
  late final String? expireDate;

  CustomerPaginatedProductEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productStatusId = json['product_status_id'];
    productMainImage = json['product_main_image'];
    productPrice = json['product_price'];
    expireDate = json['expire_date'];
    customerPhone = json['customer_phone'];
    productDetails = List.from(json['product_details'])
        .map((e) => ProductDetails.fromJson(e))
        .toList();
    productStatus = ProductStatus.fromJson(json['product_status']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['customer_id'] = customerId;
    _data['product_status_id'] = productStatusId;
    _data['product_main_image'] = productMainImage;
    _data['product_price'] = productPrice;
    _data['customer_phone'] = customerPhone;
    _data['product_details'] = productDetails.map((e) => e.toJson()).toList();
    _data['product_status'] = productStatus.toJson();
    _data['user'] = user.toJson();
    return _data;
  }
}

class ProductDetails {
  ProductDetails({
    required this.productId,
    required this.productName,
    required this.languageId,
  });
  late final int productId;
  late final String productName;
  late final int languageId;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['product_name'] = productName;
    _data['language_id'] = languageId;
    return _data;
  }
}

class ProductStatus {
  ProductStatus({
    required this.id,
    required this.productStatusCode,
    required this.productStatusDetails,
  });
  late final int id;
  late final int productStatusCode;
  late final List<ProductStatusDetails> productStatusDetails;

  ProductStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productStatusCode = json['product_status_code'];
    productStatusDetails = List.from(json['product_status_details'])
        .map((e) => ProductStatusDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_status_code'] = productStatusCode;
    _data['product_status_details'] =
        productStatusDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProductStatusDetails {
  ProductStatusDetails({
    required this.statusName,
    required this.productStatusId,
  });
  late final String statusName;
  late final int productStatusId;

  ProductStatusDetails.fromJson(Map<String, dynamic> json) {
    statusName = json['status_name'];
    productStatusId = json['product_status_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_name'] = statusName;
    _data['product_status_id'] = productStatusId;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.fullName,
  });
  late final int id;
  late final String fullName;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['full_name'] = fullName;
    return _data;
  }
}
