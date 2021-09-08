part of 'add_coupon_bloc.dart';

abstract class AddCouponState extends Equatable {
  const AddCouponState();

  @override
  List<Object> get props => [];
}

class AddCouponInitial extends AddCouponState {}

class AddCouponLoading extends AddCouponState {}

class AddCouponSuccess extends AddCouponState {
  const AddCouponSuccess(this.response);
  final ResponseModel response;
}

class AddCouponFailed extends AddCouponState {
  const AddCouponFailed(this.e);
  final Object e;
}
