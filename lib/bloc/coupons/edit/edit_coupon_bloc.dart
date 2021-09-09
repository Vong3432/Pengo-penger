import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:penger/bloc/coupons/coupon_repo.dart';
import 'package:penger/models/coupon_model.dart';
import 'package:penger/models/response_model.dart';

part 'edit_coupon_event.dart';
part 'edit_coupon_state.dart';

class EditCouponBloc extends Bloc<EditCouponEvent, EditCouponState> {
  EditCouponBloc() : super(EditCouponInitial());

  final CouponRepo _repo = CouponRepo();

  @override
  Stream<EditCouponState> mapEventToState(
    EditCouponEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is UpdateCouponEvent) {
      yield* _mapUpdateCouponToState(event.coupon);
    }
  }

  Stream<EditCouponState> _mapUpdateCouponToState(Coupon coupon) async* {
    try {
      yield EditCouponLoading();
      final ResponseModel response = await _repo.editCoupon(coupon);
      await Future.delayed(const Duration(seconds: 1));
      yield EditCouponSuccess(response);
    } catch (e) {
      yield EditCouponFailed(e);
    }
  }
}
