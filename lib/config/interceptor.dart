
import 'package:bolt/constant/constants.dart';
import 'package:bolt/util/log_util.dart';
import 'package:dio/dio.dart';
import 'package:sp_util/sp_util.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final String accessToken = SpUtil.getString(Constants.accessToken) ?? '';
    if (accessToken.isEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }
}

class LoginInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.d('LoginInterceptor request: ${options.uri}${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d('LoginInterceptor response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.d('LoginInterceptor error: ${err.message}');
    super.onError(err, handler);
  }
}

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.d('RequestInterceptor request: ${options.uri}${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d('RequestInterceptor response: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.d('RequestInterceptor error: ${err.message}');
    super.onError(err, handler);
  }
}