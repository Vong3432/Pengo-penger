import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/response_model.dart';

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

  Future<BookingCategory> fetchBookingCategory(int id) async {
    try {
      final response = await _apiHelper.get('/penger/booking-categories/$id');
      final data = response.data['data'];

      final BookingCategory bookingCategory =
          BookingCategory.fromJson(data as Map<String, dynamic>);

      return bookingCategory;
    } catch (e) {
      debugPrint("err cat: ${e.toString()}");
      throw Exception(e);
    }
  }

  Future<ResponseModel> addBookingCategory(BookingCategory category) async {
    try {
      final response = await _apiHelper.post(
        '/penger/booking-categories',
        data: category.toJson(),
        isFormData: false,
      );
      return ResponseModel.fromResponse(response);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception((e as DioError).error);
    }
  }

  Future<ResponseModel> updateBookingCategory(BookingCategory category) async {
    try {
      final response = await _apiHelper.put(
        '/penger/booking-categories/${category.id}',
        data: category.toJson(),
        isFormData: false,
      );
      return ResponseModel.fromResponse(response);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception((e as DioError).error);
    }
  }
}
