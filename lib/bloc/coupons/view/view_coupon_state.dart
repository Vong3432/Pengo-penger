part of 'view_coupon_bloc.dart';

abstract class ViewCouponState extends Equatable {
  const ViewCouponState();

  @override
  List<Object> get props => [];
}

class ViewCouponInitial extends ViewCouponState {}

class ViewCouponLoading extends ViewCouponState {}

class ViewCouponLoaded extends ViewCouponState {
  const ViewCouponLoaded(this.coupon);
  final Coupon coupon;
}

class ViewCouponNotLoaded extends ViewCouponState {
  const ViewCouponNotLoaded(this.e);
  final Object e;
}
