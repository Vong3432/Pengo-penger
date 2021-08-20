import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
      final auth = Auth.fromJson(response.data!['data']);

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
    File avatar,
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
      final Auth auth = Auth.fromJson(response.data!['data']);
      return auth;
    } catch (e) {
      throw Exception(e);
    }
  }
}
