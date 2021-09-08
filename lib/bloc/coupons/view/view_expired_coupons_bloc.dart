import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/coupons/coupon_repo.dart';
import 'package:penger/models/coupon_model.dart';

part 'view_expired_coupons_event.dart';
part 'view_expired_coupon_state.dart';

class ViewExpiredCouponsBloc
    extends Bloc<ViewExpiredCouponsEvent, ViewExpiredCouponsState> {
  ViewExpiredCouponsBloc() : super(ViewExpiredCouponsInitial());

  final CouponRepo _repo = CouponRepo();

  @override
  Stream<ViewExpiredCouponsState> mapEventToState(
    ViewExpiredCouponsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchExpiredCouponsEvent) {
      yield* _mapFetchExpiredToState();
    }
  }

  Stream<ViewExpiredCouponsState> _mapFetchExpiredToState() async* {
    try {
      yield ViewExpiredCouponsLoading();
      final List<Coupon> coupons = await _repo.fetchCoupons(type: 'expired');
      yield ViewExpiredCouponsLoaded(coupons);
    } catch (e) {
      yield ViewExpiredCouponsLoadedFailed(e);
    }
  }
}
