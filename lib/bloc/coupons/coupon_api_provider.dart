import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:penger/helpers/api/api_helper.dart';
import 'package:penger/models/coupon_model.dart';
import 'package:penger/models/response_model.dart';

class CouponApiProvider {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<Coupon>> fetchCoupons(String? type) async {
    try {
      Map<String, String> _map = {};

      if (type != null) {
        _map["type"] = type;
      }

      final response =
          await _apiHelper.get('/penger/coupons', queryParameters: _map);

      final data = response.data['data']['data'] as List;
      List<Coupon> coupons = List<Coupon>.from(
          data.map((i) => Coupon.fromJson(i as Map<String, dynamic>)));
      return coupons;
    } catch (e) {
      debugPrint("err_coupons: ${e.toString()}");
      throw Exception((e as DioError).error);
    }
  }

  Future<Coupon> fetchCoupon({required int id}) async {
    try {
      final response = await _apiHelper.get('/penger/coupons/${id}');
      final Coupon data =
          Coupon.fromJson(response.data['data'] as Map<String, dynamic>);
      return data;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception((e as DioError).error);
    }
  }

  Future<ResponseModel> addCoupon(Coupon coupon) async {
    try {
      final response = await _apiHelper.post(
        '/penger/coupons',
        data: coupon.toJson(),
      );
      debugPrint(response.toString());
      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      debugPrint(e.toString());
      throw e.response!.data['msg'].toString();
    }
  }

  Future<ResponseModel> editCoupon(Coupon coupon) async {
    try {
      debugPrint("coupon: ${coupon.toJson()}");
      final response = await _apiHelper.put(
        '/penger/coupons/${coupon.id}',
        data: coupon.toJson(),
      );
      return ResponseModel.fromResponse(response);
    } on DioError catch (e) {
      throw e.response!.data['msg'].toString();
    }
  }
}
