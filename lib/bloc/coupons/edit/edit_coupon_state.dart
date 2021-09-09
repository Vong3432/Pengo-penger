part of 'edit_coupon_bloc.dart';

abstract class EditCouponState extends Equatable {
  const EditCouponState();

  @override
  List<Object> get props => [];
}

class EditCouponInitial extends EditCouponState {}

class EditCouponLoading extends EditCouponState {}

class EditCouponSuccess extends EditCouponState {
  const EditCouponSuccess(this.response);
  final ResponseModel response;
}

class EditCouponFailed extends EditCouponState {
  const EditCouponFailed(this.e);
  final Object e;
}
