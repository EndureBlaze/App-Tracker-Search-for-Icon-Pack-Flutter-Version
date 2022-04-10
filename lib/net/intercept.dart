import 'package:dio/dio.dart';

class LogInterceptor extends Interceptor {
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _startTime = DateTime.now();
    print('---Request Start---');
    print('method: ${options.method}');
    print('uri: ${options.uri}');
    print('headers: ${options.headers}');
    print('queryParameters: ${options.queryParameters}');
    print('data: ${options.data}');
    print('contentType: ${options.contentType}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _endTime = DateTime.now();
    final int duration = _endTime.difference(_startTime).inMilliseconds;
    print('---Request End: 耗时 $duration 毫秒---');
    print('uri: ${response.realUri}');
    print('statusCode: ${response.statusCode}');
    print('data: ${response.data}');
    print('headers: ${response.headers}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('---Resuest Error: ${err.toString()}');
    super.onError(err, handler);
  }
}
