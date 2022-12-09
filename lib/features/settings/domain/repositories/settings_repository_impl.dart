import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/models/api_response.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/network/netwok_info.dart';
import 'package:elite_auction/features/settings/domain/entities/about_us_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/company_info_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/currencies_entity.dart';
import 'package:elite_auction/features/settings/domain/entities/customer_paginated_product_entity.dart';
import 'package:elite_auction/features/settings/domain/repositories/settings_repository.dart';

import '../../../../core/models/pagination_entity.dart';
import '../../../../core/models/standard_pagination_params.dart';
import '../../data/remote/data_sources/settings_remote_data_source.dart';
import '../entities/my_product_details_entity.dart';
import '../entities/order_entity.dart';
import '../params/my_order_details_params.dart';
import '../params/order_details_params.dart';

class SettingsRepositoryImp implements SettingsRepository {
  final NetworkInfo _networkInfo;
  final SettingsRemoteDataSource _settingsRemoteDataSource;
  SettingsRepositoryImp(this._networkInfo, this._settingsRemoteDataSource);
  @override
  Future<ApiResponse<BaseEntity<CurrenciesEntity>>> getCurrencies() async {
    return await _getResultWithOutPagination(
      () => _settingsRemoteDataSource.getCurrencies(),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<MyProductDetailsEntity>>> getMyProductDetails(MyProductDetailsParams params) async {
    return await _getResultWithOutPagination(
          () => _settingsRemoteDataSource.getMyProductDetails(params),
    );
  }


  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<PaginatedOrderEntity>>>>
      getOrders(StandardPaginationParams params) async {
    return await _getResultWithPagination(
      () => _settingsRemoteDataSource.getOrders(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<AboutUsEntity>>> getAboutUs() async {
    return await _getResultWithOutPagination(
      () => _settingsRemoteDataSource.getAboutUs(),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<CompanyInfoEntity>>> getCompanyInfo() async {
    return await _getResultWithOutPagination(
      () => _settingsRemoteDataSource.getCompanyInfo(),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<OrderResponseEntity>>> getOrderDetails(
      OrderDetailsParams params) async {
    return await _getResultWithOutPagination(
      () => _settingsRemoteDataSource.getOrderDetails(params),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<PaginationEntity<CustomerPaginatedProductEntity>>>> getMyProducts(StandardPaginationParams params) 
 async {
    return await _getResultWithPagination(
      () => _settingsRemoteDataSource.getMyProducts(params),
    );  }
  Future<ApiResponse<BaseEntity<T>>> _getResultWithOutPagination<T>(
      Future<BaseEntity<T>> Function() getPagination) async {
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
    }
    catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

}
