import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:elite_auction/core/api/logging_interceptor.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/foundation.dart';

import '../utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'api_consumer.dart';
import 'end_points.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;
  late Map<String, String> _headers;

  DioConsumer({required this.client}) {
    client.options
      ..sendTimeout = 10 * 100000
      ..connectTimeout = 60 * 100000
      ..receiveTimeout = 30 * 100000
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = true;
    if (kDebugMode) {
      client.interceptors.add(di.sl<LoggingInterceptor>());
    }
    client.interceptors.add(di.sl<DioCacheInterceptor>());
    //this is for avoiding certificates error cause by dio
    //https://issueexplorer.com/issue/flutterchina/dio/1285
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }

  void setHeaders() {
    _headers = {
      AppStrings.accept: AppStrings.applicationJson,
      AppStrings.contentType: AppStrings.applicationJson,
      AppStrings.authorization:
          AppStrings.bearer + AppSharedPreferences.accessToken.toString(),
      AppStrings.lang: AppSharedPreferences.lang ?? AppStrings.englishCode,
      AppStrings.currency: AppSharedPreferences.currencyId.toString(),
    };
  }

  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    setHeaders();

    try {
      final response = await client.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(
          headers: _headers,
          contentType: AppStrings.jsonContentType,
        ).copyWith(),
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      FormData? formData,
      Map<String, dynamic>? queryParameters}) async {
    setHeaders();

    try {
      final response = await client.post(path,
          queryParameters: queryParameters,
          options: Options(
              headers: _headers,
              contentType:
                  formData == null ? AppStrings.jsonContentType : null),
          data: formData ?? body);
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    setHeaders();
    try {
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
        options:
            Options(headers: _headers, contentType: AppStrings.jsonContentType),
      );
      return _handleOnlineResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  dynamic _handleOnlineResponseAsJson(Response response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }
}
