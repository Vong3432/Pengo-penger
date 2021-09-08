import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:penger/bloc/coupons/coupon_repo.dart';
import 'package:penger/models/coupon_model.dart';
import 'package:penger/models/response_model.dart';

part 'add_coupon_event.dart';
part 'add_coupon_state.dart';

class AddCouponBloc extends Bloc<AddCouponEvent, AddCouponState> {
  AddCouponBloc() : super(AddCouponInitial());

  final CouponRepo _repo = CouponRepo();

  @override
  Stream<AddCouponState> mapEventToState(
    AddCouponEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is CreateCouponEvent) {
      yield* _mapAddCouponToState(event.coupon);
    }
  }

  Stream<AddCouponState> _mapAddCouponToState(Coupon coupon) async* {
    try {
      yield AddCouponLoading();
      debugPrint("HIT");
      final ResponseModel response = await _repo.addCoupon(coupon);
      yield AddCouponSuccess(response);
    } catch (e) {
      yield AddCouponFailed(e);
    }
  }
}
