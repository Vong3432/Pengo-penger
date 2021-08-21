import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/booking_item_model.dart';

class BookingItemApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingItem>> fetchBookingItems({int? catId}) async {
    try {
      final response = await _apiHelper.get('/penger/booking-items');
      final data = response.data['data'] as List;
      List<BookingItem> bookingItems =
          List<BookingItem>.from(data.map((i) => BookingItem.fromJson(i)));
      return bookingItems;
    } catch (e) {
      debugPrint("err_item: ${e.toString()}");
      throw Exception(e);
    }
  }
}
