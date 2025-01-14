import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rave_flutter/src/common/rave_pay_initializer.dart';
import 'package:rave_flutter/src/common/rave_utils.dart';
import 'package:rave_flutter/src/repository/repository.dart';

class HttpService {
  static HttpService get instance => getIt<HttpService>();

  late Dio _dio;

  Dio get dio => _dio;

  HttpService._(RavePayInitializer initializer) {
    var options = BaseOptions(
      baseUrl: initializer.staging
          ? "https://ravesandboxapi.flutterwave.com"
          : "https://api.ravepay.co",
      responseType: ResponseType.json,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );
    _dio = Dio(options);
    if (initializer.staging) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: printWrapped,
        ),
      );
    }
  }

  factory HttpService(RavePayInitializer initializer) =>
      HttpService._(initializer);
}
