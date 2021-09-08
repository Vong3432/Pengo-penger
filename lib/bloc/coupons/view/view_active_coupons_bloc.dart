import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/coupons/coupon_repo.dart';
import 'package:penger/models/coupon_model.dart';

part 'view_active_coupons_event.dart';
part 'view_active_coupon_state.dart';

class ViewActiveCouponsBloc
    extends Bloc<ViewActiveCouponsEvent, ViewActiveCouponsState> {
  ViewActiveCouponsBloc() : super(ViewActiveCouponsInitial());

  final CouponRepo _repo = CouponRepo();

  @override
  Stream<ViewActiveCouponsState> mapEventToState(
    ViewActiveCouponsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchActiveCouponsEvent) {
      yield* _mapFetchActiveCouponsToState();
    }
  }

  Stream<ViewActiveCouponsState> _mapFetchActiveCouponsToState() async* {
    try {
      yield ViewActiveCouponsLoading();
      final List<Coupon> coupons = await _repo.fetchCoupons();
      yield ViewActiveCouponsLoaded(coupons);
    } catch (e) {
      yield ViewActiveCouponsLoadedFailed(e);
    }
  }
}
