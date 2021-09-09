part of 'view_coupon_bloc.dart';

abstract class ViewCouponEvent extends Equatable {
  const ViewCouponEvent();

  @override
  List<Object> get props => [];
}

class FetchCouponInfo extends ViewCouponEvent {
  const FetchCouponInfo(this.id);
  final int id;
}
