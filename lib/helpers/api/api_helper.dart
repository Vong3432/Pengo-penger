import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:penger/helpers/storage/shared_preference_helper.dart';
import 'package:penger/models/auth_model.dart';

class ApiHelper {
  //https://medium.com/flutter-community/implementing-bloc-pattern-using-flutter-bloc-62a62e0319b5

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._constructor() {
    init();
  }
  static final _instance = ApiHelper._constructor();

  void init() {
    SharedPreferencesHelper _helper = SharedPreferencesHelper();
    _dio.interceptors.addAll([
      InterceptorsWrapper(onError:
          (DioError error, ErrorInterceptorHandler errorInterceptorHandler) {
        debugPrint(error.toString());
        errorInterceptorHandler.reject(error);
      }, onRequest:
          (RequestOptions request, RequestInterceptorHandler handler) async {
        _dio.interceptors.requestLock.lock();
        final prefs = await _helper.getKey("user");

        if (prefs != null) {
          // return handler.reject(
          //     DioError(requestOptions: request, error: "Not authenticated"),
          //     true);
          final Auth auth =
              Auth.fromJson(jsonDecode(prefs) as Map<String, dynamic>);

          request.headers["Authorization"] = "Bearer ${auth.token}";
          debugPrint(request.contentType);
          if (auth.selectedPenger != null) {
            request.queryParameters = {
              ...request.queryParameters,
              "penger_id": auth.selectedPenger!.id.toString()
            };
          }

          // debugPrint("sh $prefs");
          // debugPrint("qs ${request.queryParameters.toString()}");
        }
        _dio.interceptors.requestLock.unlock();

        handler.next(request);
      })
    ]);
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['HOST']}/',
    connectTimeout: 60000, //1m
    receiveTimeout: 60000, //1m
  ));

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onReceiveProgress}) async {
    return _dio.get(url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<Map<String, dynamic>>> post(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      bool? isFormData,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    return _dio.post(url,
        data: data != null
            ? (isFormData == true ? FormData.fromMap(data) : data)
            : null,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<Map<String, dynamic>>> put(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      bool? isFormData,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    return _dio.put(url,
        data: data != null
            ? (isFormData == true ? FormData.fromMap(data) : data)
            : null,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<Map<String, dynamic>>> del(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool? isFormData,
    CancelToken? cancelToken,
  }) async {
    return _dio.delete(
      url,
      data: data != null
          ? (isFormData == true ? FormData.fromMap(data) : data)
          : null,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
