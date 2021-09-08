part of 'view_expired_coupons_bloc.dart';

abstract class ViewExpiredCouponsEvent extends Equatable {
  const ViewExpiredCouponsEvent();

  @override
  List<Object> get props => [];
}

class FetchExpiredCouponsEvent extends ViewExpiredCouponsEvent {}
