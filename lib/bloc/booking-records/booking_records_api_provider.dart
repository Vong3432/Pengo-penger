import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/booking_record_model.dart';

class BookingRecordApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingRecord>> fetchRecords(
    bool showToday,
    bool showExpired,
  ) async {
    try {
      final Map<String, String> _map = {};

      if (showToday) {
        _map["show_today"] = 1.toString();
      }

      if (showExpired) {
        _map["show_expired"] = 1.toString();
      }

      final response =
          await _apiHelper.get('/penger/records', queryParameters: _map);

      final data = response.data['data'] as List;
      List<BookingRecord> records = List<BookingRecord>.from(
          data.map((i) => BookingRecord.fromJson(i as Map<String, dynamic>)));
      return records;
    } catch (e) {
      debugPrint("err_records: ${e.toString()}");
      throw Exception((e as DioError).error);
    }
  }

  Future<BookingRecord> fetchBookingRecord({required int id}) async {
    try {
      final response = await _apiHelper.get('/penger/records/${id}');
      final BookingRecord data =
          BookingRecord.fromJson(response.data['data'] as Map<String, dynamic>);
      return data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception((e as DioError).error);
    }
  }

  Future<void> verifyBooking({required int id}) async {
    try {
      debugPrint("verify $id");
      await _apiHelper.put('/penger/records/${id}');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception((e as DioError).error);
    }
  }
}
