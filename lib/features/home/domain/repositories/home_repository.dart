import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/home/domain/entities/advertisements_entity.dart';
import 'package:elite_auction/features/home/domain/entities/categories_entity.dart';
import 'package:elite_auction/features/home/domain/entities/paginated_product_entity.dart';
import 'package:elite_auction/features/home/domain/entities/subcategories_entity.dart';
import 'package:elite_auction/features/home/domain/entities/user_review_entity.dart';
import 'package:elite_auction/features/home/domain/params/product_params.dart';
import 'package:elite_auction/features/home/domain/params/shop_categories_params.dart';
import 'package:elite_auction/features/home/domain/params/user_review_params.dart';

import '../../../../core/models/api_response.dart';
import '../../../../core/models/base_entity.dart';
import '../../../../core/models/pagination_entity.dart';
import '../../../../core/models/standard_pagination_params.dart';
import '../../../settings/domain/entities/my_product_details_entity.dart';
import '../bodies/add_product_body.dart';
import '../bodies/add_review_on_product_body.dart';
import '../entities/product_response_entity.dart';
import '../entities/shop_categories_entity.dart';
import '../entities/shop_entity.dart';
import '../entities/subsubcategories_entity.dart';
import '../params/products_with_pagination_params.dart';
import '../params/subcategories_params.dart';

abstract class HomeRepository {
  Future<ApiResponse<BaseEntity<ShopCategoriesEntity>>> getShopCategories(
      ShopCategoriesParams params);

  Future<ApiResponse<BaseEntity<CategoriesEntity>>> getCategories();

  Future<ApiResponse<BaseEntity<SubCategoriesEntity>>> getSubcategories(
      SubCategoriesParams params);
  Future<ApiResponse<BaseEntity<SubsubcategoriesEntity>>> getSubsubcategories(
      int subcategoryId);

  Future<ApiResponse<BaseEntity<ProductResponseEntity>>> getProduct(
      ProductParams params);

  Future<ApiResponse<BaseEntity<ProductResponseEntity>>> getShopProduct(
      ProductParams params);

  Future<ApiResponse<BaseEntity<AdvertisementsEntity>>> getAdvertisements();

  Future<ApiResponse<BaseEntity<UserReviewEntity?>>> getUserReview(
      UserReviewParams params);

  Future<ApiResponse<BaseEntity<PaginationEntity<ShopEntity>>>> getAllShops(
      StandardPaginationParams params);

  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getShopProducts(ProductsWithPaginationParams params);

  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getSubcategoryProducts(ProductsWithPaginationParams params);  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getSubsubcategoryProducts(ProductsWithPaginationParams params);

  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getSearchAllProducts(ProductsWithPaginationParams params);

  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getShopProductSimilarProducts(ProductsWithPaginationParams params);

  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getOwnerProductSimilarProducts(ProductsWithPaginationParams params);

  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getLastAddedProducts(ProductsWithPaginationParams params);

  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getMostPurchasedProducts(ProductsWithPaginationParams params);

  Future<ApiResponse<EmptySuccessResponseEntity>> addReviewOnProduct(
      AddReviewOnProductBody body);
  Future<ApiResponse<EmptySuccessResponseEntity>> addProduct(
      AddProductBody body);

  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedProductEntity>>>>
      getMostPopularProducts(ProductsWithPaginationParams params);  Future<ApiResponse<BaseEntity<PaginationEntity<MyProductDetailsEntity>>>>
      getAllCustomersProducts(ProductsWithPaginationParams params);
}
