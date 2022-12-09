import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/pagination_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/about_us_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/company_info_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/currencies_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/customer_paginated_product_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/order_entity.dart';
import 'package:elite_auction/features/settings/domain/params/my_order_details_params.dart';
import 'package:elite_auction/features/settings/domain/params/order_details_params.dart';

import '../../../../core/models/api_response.dart';
import '../../../../core/models/standard_pagination_params.dart';
import '../entities/my_product_details_entity.dart';

abstract class SettingsRepository {
  Future<ApiResponse<BaseEntity<CurrenciesEntity>>> getCurrencies();
  Future<ApiResponse<BaseEntity<OrderResponseEntity>>> getOrderDetails(
      OrderDetailsParams params);
  Future<ApiResponse<BaseEntity<AboutUsEntity>>> getAboutUs();
  Future<ApiResponse<BaseEntity<MyProductDetailsEntity>>> getMyProductDetails(MyProductDetailsParams params);

  Future<ApiResponse<BaseEntity<CompanyInfoEntity>>> getCompanyInfo();
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedOrderEntity>>>>
      getOrders(StandardPaginationParams params);
  Future<ApiResponse<BaseEntity<PaginationEntity<CustomerPaginatedProductEntity>>>>
      getMyProducts(StandardPaginationParams params);
}
