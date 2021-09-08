part of 'view_active_coupons_bloc.dart';

abstract class ViewActiveCouponsState extends Equatable {
  const ViewActiveCouponsState();

  @override
  List<Object> get props => [];
}

class ViewActiveCouponsInitial extends ViewActiveCouponsState {}

class ViewActiveCouponsLoading extends ViewActiveCouponsState {}

class ViewActiveCouponsLoaded extends ViewActiveCouponsState {
  const ViewActiveCouponsLoaded(this.coupons);
  final List<Coupon> coupons;
}

class ViewActiveCouponsLoadedFailed extends ViewActiveCouponsState {
  const ViewActiveCouponsLoadedFailed(this.e);
  final Object e;
}
