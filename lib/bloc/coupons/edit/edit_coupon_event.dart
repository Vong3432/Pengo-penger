part of 'edit_coupon_bloc.dart';

abstract class UpdateCouponEvent extends Equatable {
  const UpdateCouponEvent();

  @override
  List<Object> get props => [];
}

class EditCouponEvent extends UpdateCouponEvent {
  const EditCouponEvent(this.coupon);
  final Coupon coupon;
}
