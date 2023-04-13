import 'dart:convert';

import 'package:bolt/constant/constants.dart';
import 'package:dio/dio.dart';

class DioManager {

  static final DioManager instance = DioManager._internal();

  static late Dio dio;

  DioManager._internal() {
    var options = BaseOptions(
      baseUrl: Constants.serviceUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
    dio = Dio(options);
  }

  factory DioManager() => instance;

  Future<Map<String, dynamic>> post(String url, params, [Function? successCallback, Function? errorCallback]) async {
    Response? response;
    try {
      response = await dio.post(url, data: params);
    } catch (error) {
      if (errorCallback != null) {
        errorCallback(error.toString());
      } else {
        return <String, dynamic>{};
      }
    }
    if (response?.statusCode == 200) {
      Map<String, dynamic> data = json.decode(json.encode(response?.data));
      if (data['status'] == 200) {
        if (successCallback != null) {
          successCallback(data['data']);
        } else {
          return data['data'];
        }
      } else {
        if (errorCallback != null) {
          errorCallback(data["reason"]);
        } else {
          return <String, dynamic>{};
        }
      }
    } else {
      if (errorCallback != null) {
        errorCallback(response.toString());
      } else {
        return <String, dynamic>{};
      }
    }
    return <String, dynamic>{};
  }
}