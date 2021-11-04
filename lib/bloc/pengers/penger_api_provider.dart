import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/penger_model.dart';
import 'package:penger/models/response_model.dart';

class PengerApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<Penger>> fetchPengers() async {
    try {
      final response = await _apiHelper.get('/penger/pengers');
      final data = response.data['data'] as List;
      final List<Penger> pengers = List<Penger>.from(
        data.map(
          (i) => Penger.fromJson(i as Map<String, dynamic>),
        ),
      );
      return pengers;
    } catch (e) {
      debugPrint("fetPenger err ${e.toString()}");
      throw Exception(e);
    }
  }

  Future<Penger> fetchPenger(int id) async {
    try {
      final response = await _apiHelper.get('/penger/pengers/$id');
      final data = response.data['data'];
      final Penger penger = Penger.fromJson(data as Map<String, dynamic>);
      return penger;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<ResponseModel> createPenger(
    String name,
    XFile poster,
    String locationName,
    double lat,
    double lng,
    String? description,
  ) async {
    try {
      final blob = await MultipartFile.fromFile(poster.path,
          filename: poster.name, contentType: MediaType("image", "png"));
      final response = await _apiHelper.post(
        '/penger/pengers',
        data: <String, dynamic>{
          "name": name,
          "location_name": locationName,
          "description": description,
          "logo": blob,
          "geolocation": {
            "latitude": lat,
            "longitude": lng,
          }
        },
        isFormData: true,
      );
      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  Future<ResponseModel> updatePenger(
    int id,
    String name,
    XFile? poster,
    String locationName,
    double lat,
    double lng,
    String? description,
  ) async {
    try {
      final Map<String, dynamic> map = <String, dynamic>{};
      map["name"] = name;
      map["location_name"] = locationName;
      map["description"] = description;
      if (poster != null) {
        final blob = await MultipartFile.fromFile(poster.path,
            filename: poster.name, contentType: MediaType("image", "png"));
        map["logo"] = blob;
      }
      map["geolocation"] = {
        "latitude": lat,
        "longitude": lng,
      };

      final response = await _apiHelper.put(
        '/penger/pengers/$id',
        data: map,
        isFormData: true,
      );
      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  Future<int> fetchTotalStaff() async {
    try {
      final response = await _apiHelper.get(
        '/penger/total-staff',
      );
      final int totalStaff = response.data['data'] as int;
      return totalStaff;
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  Future<int> fetchTotalBookingToday() async {
    try {
      final response = await _apiHelper.get(
        '/penger/total-booking-today',
      );
      final int totalStaff = response.data['data'] as int;
      return totalStaff;
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  // Future<Penger> fetchBookingItems(int id, {int? limit, int? pageNum}) async {
  //   try {
  //     final response = await _apiHelper.get('/core/pengers/{id}?limit=${limit}',
  //         queryParameters: {'limit': limit, 'page': pageNum});

  //     final data = response.data['data'];
  //     Penger penger = Penger.fromJson(data as Map<String, dynamic>);

  //     return penger;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     throw Exception(e);
  //   }
  // }
}
