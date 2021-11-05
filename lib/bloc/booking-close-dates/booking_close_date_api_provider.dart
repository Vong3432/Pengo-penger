import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/booking_close_date_model.dart';
import 'package:penger/models/response_model.dart';

class BookingCloseDateApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingCloseDate>> fetchCloseDates() async {
    try {
      final response = await _apiHelper.get('/penger/close-dates');
      final data = response.data['data'] as List;
      final List<BookingCloseDate> list = List<BookingCloseDate>.from(
        data.map(
          (i) => BookingCloseDate.fromJson(i as Map<String, dynamic>),
        ),
      );
      return list;
    } catch (e) {
      debugPrint("fetch close date list err ${e.toString()}");
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

  Future<ResponseModel> createCloseDate({
    required String name,
    required String from,
    required String to,
    required int keyId,
    required CloseDateType type,
  }) async {
    try {
      final response = await _apiHelper.post(
        '/penger/close-dates',
        data: <String, dynamic>{
          "name": name,
          "from": from,
          "to": to,
          "key_id": keyId,
          "type": type.toString().split(".").last,
        },
      );
      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  Future<ResponseModel> updateCloseDate({
    required int id,
    required String name,
    required String from,
    required String to,
    required int keyId,
    required CloseDateType type,
  }) async {
    try {
      final response = await _apiHelper.put(
        '/penger/close-dates/$id',
        data: <String, dynamic>{
          "name": name,
          "from": from,
          "to": to,
          "key_id": keyId,
          "type": type.toString().split(".").last,
        },
      );
      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }

  Future<void> delCloseDate(
    int id,
  ) async {
    try {
      final response = await _apiHelper.del(
        '/penger/close-dates/$id',
      );
      // return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw e.response!.data['msg'].toString();
    }
  }
}
