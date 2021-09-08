part of 'view_active_coupons_bloc.dart';

abstract class ViewActiveCouponsEvent extends Equatable {
  const ViewActiveCouponsEvent();

  @override
  List<Object> get props => [];
}

class FetchActiveCouponsEvent extends ViewActiveCouponsEvent {}
