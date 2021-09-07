import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/booking_category_model.dart';

class BookingCategoryApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<BookingCategory>> fetchBookingCategories() async {
    try {
      final response = await _apiHelper.get('/penger/booking-categories');
      final data = response.data['data'] as List;

      List<BookingCategory> bookingCategories = List<BookingCategory>.from(
          data.map((i) => BookingCategory.fromJson(i as Map<String, dynamic>)));

      return bookingCategories;
    } catch (e) {
      debugPrint("err cat: ${e.toString()}");
      throw Exception(e);
    }
  }
}
