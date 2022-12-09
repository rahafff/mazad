import 'package:dio/dio.dart';
import 'package:elite_auction/features/home/domain/bodies/add_review_on_product_body.dart';
import 'package:elite_auction/features/home/domain/entities/subsubcategories_entity.dart';
import 'package:elite_auction/features/home/domain/entities/user_review_entity.dart';
import 'package:elite_auction/features/home/domain/params/user_review_params.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/models/base_entity.dart';
import '../../../../../core/models/empty_success_response_entity.dart';
import '../../../../../core/models/pagination_entity.dart';
import '../../../../../core/models/standard_pagination_params.dart';
import '../../../../settings/domain/entities/my_product_details_entity.dart';
import '../../../domain/bodies/add_product_body.dart';
import '../../../domain/entities/advertisements_entity.dart';
import '../../../domain/entities/categories_entity.dart';
import '../../../domain/entities/paginated_product_entity.dart';
import '../../../domain/entities/product_response_entity.dart';
import '../../../domain/entities/shop_categories_entity.dart';
import '../../../domain/entities/shop_entity.dart';
import '../../../domain/entities/subcategories_entity.dart';
import '../../../domain/params/product_params.dart';
import '../../../domain/params/products_with_pagination_params.dart';
import '../../../domain/params/shop_categories_params.dart';
import '../../../domain/params/subcategories_params.dart';

abstract class HomeRemoteDataSource {
  Future<EmptySuccessResponseEntity> addReviewOnProduct(
      AddReviewOnProductBody body);

  Future<BaseEntity<ShopCategoriesEntity>> getShopCategories(
      ShopCategoriesParams params);

  Future<BaseEntity<SubsubcategoriesEntity>> getSubsubCategories(
      int subcategoryId);

  Future<BaseEntity<CategoriesEntity>> getCategories();

  Future<BaseEntity<UserReviewEntity?>> getUserReview(UserReviewParams params);

  Future<BaseEntity<ProductResponseEntity>> getProduct(ProductParams params);

  Future<BaseEntity<ProductResponseEntity>> getShopProduct(
      ProductParams params);

  Future<BaseEntity<AdvertisementsEntity>> getAdvertisements();

  Future<BaseEntity<SubCategoriesEntity>> getSubCategories(
      SubCategoriesParams params);

  Future<BaseEntity<PaginationEntity<ShopEntity>>> getAllShops(
      StandardPaginationParams params);

  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>> getShopProducts(
      ProductsWithPaginationParams params);

  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getSubcategoryProducts(ProductsWithPaginationParams params);
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getSubsubcategoryProducts(ProductsWithPaginationParams params);

  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getShopProductSimilarProducts(ProductsWithPaginationParams params);

  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getOwnerProductSimilarProducts(ProductsWithPaginationParams params);

  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getMostPurchasedProducts(ProductsWithPaginationParams params);

  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getLastAddedProducts(ProductsWithPaginationParams params);

  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getMostPopularProducts(ProductsWithPaginationParams params);

  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getSearchAllProducts(ProductsWithPaginationParams params);
  Future<BaseEntity<PaginationEntity<MyProductDetailsEntity>>>
      getAllCustomersProducts(ProductsWithPaginationParams params);

  Future<EmptySuccessResponseEntity> addProduct(AddProductBody body);
}

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final ApiConsumer _apiConsumer;

  HomeRemoteDataSourceImp(this._apiConsumer);

  @override
  Future<BaseEntity<ShopCategoriesEntity>> getShopCategories(
      ShopCategoriesParams params) async {
    return await _getResultWithoutPagination(
        apiCall: () => _apiConsumer.get(EndPoints.shopCategories,
            queryParameters: params.toJson()),
        fromJson: (json) => ShopCategoriesEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<ProductResponseEntity>> getProduct(
      ProductParams params) async {
    return await _getResultWithoutPagination(
        apiCall: () => _apiConsumer.get(EndPoints.product,
            queryParameters: params.toJson()),
        fromJson: (json) => ProductResponseEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<ProductResponseEntity>> getShopProduct(
      ProductParams params) async {
    return await _getResultWithoutPagination(
        apiCall: () => _apiConsumer.get(EndPoints.shopProduct,
            queryParameters: params.toJson()),
        fromJson: (json) => ProductResponseEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<CategoriesEntity>> getCategories() async {
    return await _getResultWithoutPagination(
        apiCall: () => _apiConsumer.get(
              EndPoints.categories,
            ),
        fromJson: (json) => CategoriesEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<AdvertisementsEntity>> getAdvertisements() async {
    return await _getResultWithoutPagination(
        apiCall: () => _apiConsumer.get(EndPoints.advertisements,
            queryParameters: {"slider_type": "custom_without_btn"}),
        fromJson: (json) => AdvertisementsEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<SubCategoriesEntity>> getSubCategories(
      SubCategoriesParams params) async {
    return await _getResultWithoutPagination(
        apiCall: () => _apiConsumer.get(EndPoints.subcategories,
            queryParameters: params.toJson()),
        fromJson: (json) => SubCategoriesEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<ShopEntity>>> getAllShops(
      StandardPaginationParams params) async {
    return _getResultWithPagination(
        () =>
            _apiConsumer.get(EndPoints.shops, queryParameters: params.toJson()),
        (json) => ShopEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>> getShopProducts(
      ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.shopProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getLastAddedProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.lastAddedProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getMostPopularProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.mostPopularProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getMostPurchasedProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.mostPurchasedProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getShopProductSimilarProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.shopSimilarProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getOwnerProductSimilarProducts(
          ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.ownerSimilarProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getSubcategoryProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.subcategoryProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getSearchAllProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.searchAllProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }

  @override
  Future<EmptySuccessResponseEntity> addReviewOnProduct(
      AddReviewOnProductBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.addReview,
        body: body.toJson(),
      ),
    );
  }

  @override
  Future<BaseEntity<UserReviewEntity?>> getUserReview(
      UserReviewParams params) async {
    return await _getResultWithoutPagination(
      apiCall: () => _apiConsumer.get(EndPoints.getReview,
          queryParameters: params.toJson()),
      fromJson: (json) => UserReviewEntity.fromJson(json),
    );
  }

  @override
  Future<BaseEntity<SubsubcategoriesEntity>> getSubsubCategories(
      int subcategoryId) async {
    return await _getResultWithoutPagination(
      apiCall: () => _apiConsumer.get(EndPoints.subsubcategories,
          queryParameters: {'subcategory_id': subcategoryId}),
      fromJson: (json) => SubsubcategoriesEntity.fromJson(json),
    );
  }

  @override
  Future<BaseEntity<PaginationEntity<PaginatedProductEntity>>>
      getSubsubcategoryProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.subsubcategoryProducts,
            queryParameters: params.toJson()),
        (json) => PaginatedProductEntity.fromJson(json));
  }
  @override
  Future<BaseEntity<PaginationEntity<MyProductDetailsEntity>>> getAllCustomersProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
        () => _apiConsumer.get(EndPoints.allCustomersProducts,
            queryParameters: params.toJson()),
        (json) => MyProductDetailsEntity.fromJson(json));
  }
  @override
  Future<EmptySuccessResponseEntity> addProduct(AddProductBody body) async {
    FormData formData = FormData.fromMap(await body.toMap());
    return await _getEmptySuccessResponseResult(
      () async => _apiConsumer.post(EndPoints.addProduct, formData: formData),
    );
  }

  Future<BaseEntity<PaginationEntity<T>>> _getResultWithPagination<T>(
      Future<dynamic> Function() api, T Function(dynamic json) fromJson) async {
    var response = await api();

    return BaseEntity.fromJson(
      response,
      (paginated) => PaginationEntity.fromJson(
        paginated,
        (data) => fromJson(data),
      ),
    );
  }

  Future<BaseEntity<T>> _getResultWithoutPagination<T>(
      {required Future<dynamic> Function() apiCall,
      required T Function(dynamic json) fromJson}) async {
    var response = await apiCall();
    return BaseEntity.fromJson(response, (json) => fromJson(json));
  }

  Future<EmptySuccessResponseEntity> _getEmptySuccessResponseResult<T>(
      Future<dynamic> Function() apiCall) async {
    var response = await apiCall();
    return EmptySuccessResponseEntity.fromJson(response);
  }
  

}
