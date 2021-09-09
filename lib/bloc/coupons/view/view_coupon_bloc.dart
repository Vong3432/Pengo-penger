import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:penger/bloc/coupons/coupon_repo.dart';
import 'package:penger/models/coupon_model.dart';

part 'view_coupon_event.dart';
part 'view_coupon_state.dart';

class ViewCouponBloc extends Bloc<ViewCouponEvent, ViewCouponState> {
  ViewCouponBloc() : super(ViewCouponInitial());

  final CouponRepo _repo = CouponRepo();

  @override
  Stream<ViewCouponState> mapEventToState(
    ViewCouponEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchCouponInfo) {
      yield* _mapFetchCouponToState(event.id);
    }
  }

  Stream<ViewCouponState> _mapFetchCouponToState(int id) async* {
    try {
      yield ViewCouponLoading();
      final Coupon coupon = await _repo.fetchCoupon(id: id);
      yield ViewCouponLoaded(coupon);
    } catch (e) {
      yield ViewCouponNotLoaded(e);
    }
  }
}
