import 'package:penger/bloc/coupons/coupon_api_provider.dart';
import 'package:penger/models/coupon_model.dart';
import 'package:penger/models/response_model.dart';

class CouponRepo {
  factory CouponRepo() {
    return _instance;
  }

  CouponRepo._constructor();

  static final CouponRepo _instance = CouponRepo._constructor();
  final CouponApiProvider _couponApiProvider = CouponApiProvider();

  Future<List<Coupon>> fetchCoupons({String? type}) async =>
      _couponApiProvider.fetchCoupons(type);

  Future<Coupon> fetchCoupon({required int id}) async =>
      _couponApiProvider.fetchCoupon(id: id);

  Future<ResponseModel> addCoupon(Coupon model) async =>
      _couponApiProvider.addCoupon(model);

  Future<ResponseModel> editCoupon(Coupon model) async =>
      _couponApiProvider.editCoupon(model);
}
