import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:app_tracker_search/net/intercept.dart' as interceptor;

class Api {
  static Api? _single;

  static Api getInstance() {
    return _single ??= Api._();
  }

  static late Dio _dio;

  Dio get dio => _dio;

  static const baseUrl = 'https://yrtql.imyan.ren/api';

  Api._() {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    _dio = Dio(options);

    if (kDebugMode) {
      _dio.interceptors.add(interceptor.LogInterceptor());
    }
  }

  Future<Response> search(String appName) {
    return _dio.get('/appInfo', queryParameters: {
      'q': appName,
    });
  }

  Future<Response> getIcon(String packageName) {
    return _dio.get('/appIcon', queryParameters: {
      'packageName': packageName,
    });
  }
}
