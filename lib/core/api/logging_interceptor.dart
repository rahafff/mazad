import 'dart:convert';

import 'package:colorful_print/colorful_print.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _logPrint('*** Api Error - Start ***:');

    _logPrint('URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      _logPrint('STATUS CODE: ${err.response?.statusCode?.toString()}');
    }
    _logPrint('$err');
    if (err.response != null) {
      _logPrint('ERROR BODY:');
      _printError(err.response?.data ?? "{}");
    }

    _logPrint('*** Api Error - End ***:');
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logPrint('*** API Request - Start ***');

    _printKV('URI', options.uri);
    _printKV('METHOD', options.method);
    _logPrint('HEADERS:');
    options.headers.forEach((key, v) => _printKV(' - $key', v));
    _logPrint('REQUEST BODY:');
    _printRequest(options.data ?? "{}");

    _logPrint('*** API Request - End ***');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logPrint('*** Api Response - Start ***');

    _printKV('URI', response.realUri);
    _printKV('STATUS CODE', response.statusCode);
    _printKV('REDIRECT', response.isRedirect);
    _logPrint('RESPONSE BODY:');
    _printResponse(response.data ?? "{}");

    _logPrint('*** Api Response - End ***');
    super.onResponse(response, handler);
  }

  void _printKV(String key, dynamic v) {
    _logPrint('$key: $v');
  }

  void _printResponse(msg) {
    final object = json.decode(msg.toString());
    final prettyString = const JsonEncoder.withIndent('  ').convert(object);
    if (kDebugMode) {
      printColor(prettyString, textColor: TextColor.green);
    }
  }

  void _printError(msg) {
    final object = json.decode(msg.toString());
    final prettyString = const JsonEncoder.withIndent('  ').convert(object);
    if (kDebugMode) {
      printColor(prettyString, textColor: TextColor.red);
    }
  }

  void _printRequest(msg) {
    if (msg is FormData) {
      printColor(msg.fields, textColor: TextColor.cyan);
      return;
    }
    final prettyString = const JsonEncoder.withIndent('  ').convert(msg);
    if (kDebugMode) {
      printColor(prettyString, textColor: TextColor.cyan);
    }
  }

  void _logPrint(String content) {
    if (kDebugMode) {
      print(content);
    }
  }
}
