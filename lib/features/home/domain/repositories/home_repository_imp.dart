import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/home/data/remote/data_sources/home_remote_data_source.dart';
import 'package:elite_auction/features/home/domain/bodies/add_product_body.dart';
import 'package:elite_auction/features/home/domain/bodies/add_review_on_product_body.dart';
import 'package:elite_auction/features/home/domain/entities/subsubcategories_entity.dart';
import 'package:elite_auction/features/home/domain/entities/user_review_entity.dart';
import 'package:elite_auction/features/home/domain/params/user_review_params.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/models/api_response.dart';
import '../../../../core/models/base_entity.dart';
import '../../../../core/models/pagination_entity.dart';
import '../../../../core/models/standard_pagination_params.dart';
import '../../../../core/network/netwok_info.dart';
import '../../../settings/domain/entities/my_product_details_entity.dart';
import '../entities/advertisements_entity.dart';
import '../entities/categories_entity.dart';
import '../entities/paginated_product_entity.dart';
import '../entities/product_response_entity.dart';
import '../entities/shop_categories_entity.dart';
import '../entities/shop_entity.dart';
import '../entities/subcategories_entity.dart';
import '../params/product_params.dart';
import '../params/products_with_pagination_params.dart';
import '../params/shop_categories_params.dart';
import '../params/subcategories_params.dart';
import 'home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  final NetworkInfo _networkInfo;

  HomeRepositoryImp(this._homeRemoteDataSource, this._networkInfo);
  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<ShopEntity>>>> getAllShops(
      StandardPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getAllShops(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getShopProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getShopProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getLastAddedProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getLastAddedProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getMostPopularProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getMostPopularProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getMostPurchasedProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getMostPurchasedProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getOwnerProductSimilarProducts(
          ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getOwnerProductSimilarProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getShopProductSimilarProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getShopProductSimilarProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getSubcategoryProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getSubcategoryProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getSearchAllProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getSearchAllProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<ShopCategoriesEntity>>> getShopCategories(
      ShopCategoriesParams params) async {
    return await _getResultWithOutPagination(
      () => _homeRemoteDataSource.getShopCategories(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<ProductResponseEntity>>> getProduct(
      ProductParams params) async {
    return await _getResultWithOutPagination(
      () => _homeRemoteDataSource.getProduct(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<ProductResponseEntity>>> getShopProduct(
      ProductParams params) async {
    return await _getResultWithOutPagination(
      () => _homeRemoteDataSource.getShopProduct(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<CategoriesEntity>>> getCategories() async {
    return await _getResultWithOutPagination(
      () => _homeRemoteDataSource.getCategories(),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<AdvertisementsEntity>>>
      getAdvertisements() async {
    return await _getResultWithOutPagination(
      () => _homeRemoteDataSource.getAdvertisements(),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<SubCategoriesEntity>>> getSubcategories(
      SubCategoriesParams params) async {
    return await _getResultWithOutPagination(
      () => _homeRemoteDataSource.getSubCategories(params),
    );
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> addReviewOnProduct(
      AddReviewOnProductBody body) async {
    return await _getEmptySuccessResponseEntityResult(
      () => _homeRemoteDataSource.addReviewOnProduct(body),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<UserReviewEntity?>>> getUserReview(
      UserReviewParams params) async {
    return await _getResultWithOutPagination(
      () => _homeRemoteDataSource.getUserReview(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<SubsubcategoriesEntity>>> getSubsubcategories(
      int subcategoryId) async {
    return await _getResultWithOutPagination(
      () => _homeRemoteDataSource.getSubsubCategories(subcategoryId),
    );
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> addProduct(
      AddProductBody body) async {
    return await _getEmptySuccessResponseEntityResult(
      () => _homeRemoteDataSource.addProduct(body),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getSubsubcategoryProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getSubsubcategoryProducts(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<MyProductDetailsEntity>>>>
      getAllCustomersProducts(ProductsWithPaginationParams params) async {
    return await _getResultWithPagination(
      () => _homeRemoteDataSource.getAllCustomersProducts(params),
    );
  }

  Future<ApiResponse<BaseEntity<T>>> _getResultWithOutPagination<T>(
      Future<BaseEntity<T>> Function() getResult) async {
    try {
      if (await _networkInfo.isConnected) {
      var response = await getResult();
      return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<EmptySuccessResponseEntity>>
      _getEmptySuccessResponseEntityResult<T>(
          Future<EmptySuccessResponseEntity> Function() getResult) async {
    try {
      if (await _networkInfo.isConnected) {
      var response = await getResult();
      return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  Future<ApiResponse<BaseEntity<PaginationEntity<T>>>> _getResultWithPagination<
          T>(
      Future<BaseEntity<PaginationEntity<T>>> Function() getPagination) async {
    try {
      if (await _networkInfo.isConnected) {
      var response = await getPagination();
      return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
