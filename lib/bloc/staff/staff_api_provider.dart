import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/response_model.dart';
import 'package:penger/models/user_model.dart';

class StaffApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<User>> fetchStaffList() async {
    try {
      final response = await _apiHelper.get('/penger/staff');
      final data = response.data['data'] as List;
      final List<User> staffList = List<User>.from(
        data.map(
          (i) => User.fromJson(i as Map<String, dynamic>),
        ),
      );
      return staffList;
    } catch (e) {
      debugPrint("fetch staff err ${e.toString()}");
      throw Exception(e);
    }
  }

  // Future<Penger> fetchPenger(int id) async {
  //   try {
  //     final response = await _apiHelper.get('/penger/pengers/$id');
  //     final data = response.data['data'];
  //     final Penger penger = Penger.fromJson(data as Map<String, dynamic>);
  //     return penger;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     throw Exception(e);
  //   }
  // }

  Future<ResponseModel> createStaff(
    String name,
    String password,
    String email,
    int age,
    String phone,
  ) async {
    try {
      final response = await _apiHelper.post(
        '/penger/staff',
        data: <String, dynamic>{
          "username": name,
          "password": password,
          "email": email,
          "phone": "+6$phone",
          "age": age,
        },
      );
      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  Future<ResponseModel> updateStaff(
    int id,
    String name,
    String password,
    String email,
    int age,
    String phone,
  ) async {
    try {
      final response = await _apiHelper.put(
        '/penger/staff/$id',
        data: <String, dynamic>{
          "username": name,
          "password": password,
          "email": email,
          "phone": "+6$phone",
          "age": age,
        },
      );
      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  Future<void> delStaff(
    int id,
  ) async {
    try {
      final response = await _apiHelper.del(
        '/penger/staff/$id',
      );
      // return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw e.response!.data['msg'].toString();
    }
  }
}
