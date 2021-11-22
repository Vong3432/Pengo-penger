import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/auth_model.dart';

class AuthApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Auth> login(
    String phone,
    String password,
  ) async {
    try {
      final response =
          await _apiHelper.post('auth/penger/login', data: <String, String>{
        "phone": "+6$phone",
        "password": password,
      });
      debugPrint(response.data.toString());
      final Auth auth =
          Auth.fromJson(response.data!['data'] as Map<String, dynamic>);
      return auth;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<Auth> register(
    String phone,
    String password,
    String username,
    String email,
    XFile avatar,
  ) async {
    try {
      final String fileName = avatar.path.split('/').last;
      final Map<String, dynamic> fd = {
        "phone": "+6$phone",
        "password": password,
        "username": username,
        "email": email,
        "avatar": await MultipartFile.fromFile(avatar.path, filename: fileName),
      };
      final Response<Map<String, dynamic>> response =
          await _apiHelper.post('/auth/penger/login', data: fd);
      final Auth auth =
          Auth.fromJson(response.data!['data'] as Map<String, dynamic>);
      return auth;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Auth> updateProfile({
    required int userId,
    String? phone,
    String? password,
    String? username,
    String? email,
    XFile? avatar,
  }) async {
    try {
      final Map<String, dynamic> fd = <String, dynamic>{
        "phone": phone,
        "password": password,
        "username": username,
        "email": email,
        "avatar": avatar != null
            ? await MultipartFile.fromFile(
                avatar.path,
                filename: avatar.path.split('/').last,
              )
            : null,
      };
      final Response<Map<String, dynamic>> response = await _apiHelper.put(
        '/auth/update-profile/$userId',
        data: fd,
        isFormData: true,
      );
      final Auth auth =
          Auth.fromJson(response.data!['data'] as Map<String, dynamic>);
      return auth;
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }
}
