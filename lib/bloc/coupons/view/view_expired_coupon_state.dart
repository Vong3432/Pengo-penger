part of 'view_expired_coupons_bloc.dart';

abstract class ViewExpiredCouponsState extends Equatable {
  const ViewExpiredCouponsState();

  @override
  List<Object> get props => [];
}

class ViewExpiredCouponsInitial extends ViewExpiredCouponsState {}

class ViewExpiredCouponsLoading extends ViewExpiredCouponsState {}

class ViewExpiredCouponsLoaded extends ViewExpiredCouponsState {
  const ViewExpiredCouponsLoaded(this.coupons);
  final List<Coupon> coupons;
}

class ViewExpiredCouponsLoadedFailed extends ViewExpiredCouponsState {
  const ViewExpiredCouponsLoadedFailed(this.e);
  final Object e;
}
