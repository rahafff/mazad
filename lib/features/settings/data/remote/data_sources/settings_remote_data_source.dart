import 'package:elite_auction/core/api/api_consumer.dart';
import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/models/pagination_entity.dart';
import 'package:elite_auction/core/models/standard_pagination_params.dart';
import 'package:elite_auction/features/settings/domain/entities/about_us_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/company_info_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/currencies_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/customer_paginated_product_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/my_product_details_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/order_entity.dart';
import 'package:elite_auction/features/settings/domain/params/my_order_details_params.dart';

import '../../../../../core/models/base_entity.dart';
import '../../../domain/params/order_details_params.dart';

abstract class SettingsRemoteDataSource {
  Future<BaseEntity<CurrenciesEntity>> getCurrencies();
  Future<BaseEntity<MyProductDetailsEntity>> getMyProductDetails(MyProductDetailsParams params);
  Future<BaseEntity<AboutUsEntity>> getAboutUs();
  Future<BaseEntity<CompanyInfoEntity>> getCompanyInfo();
  Future<BaseEntity<OrderResponseEntity>> getOrderDetails(
      OrderDetailsParams params);
  Future<BaseEntity<PaginationEntity<PaginatedOrderEntity>>> getOrders(
      StandardPaginationParams params);
  Future<BaseEntity<PaginationEntity<CustomerPaginatedProductEntity>>> getMyProducts(
      StandardPaginationParams params);
}

class SettingsRemoteDataSourceImp implements SettingsRemoteDataSource {
  final ApiConsumer _apiConsumer;

  SettingsRemoteDataSourceImp(this._apiConsumer);
  @override
  Future<BaseEntity<CurrenciesEntity>> getCurrencies() async {
    return await _getResultWithOutPagination(
      () => _apiConsumer.get(EndPoints.currencies),
      (json) => CurrenciesEntity.fromJson(json),
    );
  }

  @override
  Future<BaseEntity<MyProductDetailsEntity>> getMyProductDetails(params) async {
    return await _getResultWithOutPagination(
          () => _apiConsumer.get(EndPoints.customerProductDetailes,
            queryParameters: params.toJson(),
          ),
      (json) => MyProductDetailsEntity.fromJson(json),
    );
  }


  @override
  Future<BaseEntity<PaginationEntity<PaginatedOrderEntity>>> getOrders(
      StandardPaginationParams params) async {
    return await _getResultWithPagination(
      () =>
          _apiConsumer.get(EndPoints.orders, queryParameters: params.toJson()),
      (json) => PaginatedOrderEntity.fromJson(json),
    );
  }

  @override
  Future<BaseEntity<AboutUsEntity>> getAboutUs() async {
    return await _getResultWithOutPagination(
      () => _apiConsumer.get(
        EndPoints.aboutUs,
      ),
      (json) => AboutUsEntity.fromJson(json),
    );
  }

  @override
  Future<BaseEntity<CompanyInfoEntity>> getCompanyInfo() async {
    return await _getResultWithOutPagination(
      () => _apiConsumer.get(
        EndPoints.companyInfo,
      ),
      (json) => CompanyInfoEntity.fromJson(json),
    );
  }

  @override
  Future<BaseEntity<PaginationEntity<CustomerPaginatedProductEntity>>> getMyProducts(StandardPaginationParams  params
  )async {
    return await _getResultWithPagination(
      () =>
          _apiConsumer.get(EndPoints.customerProducts, queryParameters: params.toJson()),
      (json) => CustomerPaginatedProductEntity.fromJson(json),
    );}
  @override
  Future<BaseEntity<OrderResponseEntity>> getOrderDetails(params) async {
    return await _getResultWithOutPagination(
      () => _apiConsumer.get(
        EndPoints.orderDetails,
        queryParameters: params.toJson(),
      ),
      (json) => OrderResponseEntity.fromJson(json),
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

  Future<BaseEntity<T>> _getResultWithOutPagination<T>(
      Future<dynamic> Function() apiCall,
      T Function(dynamic json) fromJson) async {
    var response = await apiCall();
    return BaseEntity.fromJson(response, (json) => fromJson(json));
  }
  
}
