import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/models/response_model.dart';

class BookingItemApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingItem>> fetchBookingItems({int? catId}) async {
    try {
      final response = await _apiHelper.get('/penger/booking-items');
      final data = response.data['data'] as List;
      List<BookingItem> bookingItems = List<BookingItem>.from(
          data.map((i) => BookingItem.fromJson(i as Map<String, dynamic>)));
      return bookingItems;
    } catch (e) {
      debugPrint("err_item: ${e.toString()}");
      throw Exception((e as DioError).error);
    }
  }

  Future<BookingItem> fetchBookingItem({required int id}) async {
    try {
      final response = await _apiHelper.get('/penger/booking-items/${id}');
      final BookingItem data =
          BookingItem.fromJson(response.data['data'] as Map<String, dynamic>);
      return data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception((e as DioError).error);
    }
  }

  Future<ResponseModel> addBookingItem(BookingItemModel model) async {
    try {
      final response = await _apiHelper.post(
        '/penger/booking-items',
        data: await model.toMap(),
      );
      debugPrint(response.toString());
      return ResponseModel.fromResponse(response);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception((e as DioError).error);
    }
  }

  Future<ResponseModel> editBookingItem(BookingItemModel model) async {
    try {
      final response = await _apiHelper.put(
        '/penger/booking-items/${model.id}',
        data: await model.toMap(),
      );
      return ResponseModel.fromResponse(response);
    } catch (e) {
      throw Exception((e as DioError).error);
    }
  }
}
