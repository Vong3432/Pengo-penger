part of 'add_coupon_bloc.dart';

abstract class AddCouponEvent extends Equatable {
  const AddCouponEvent();

  @override
  List<Object> get props => [];
}

class CreateCouponEvent extends AddCouponEvent {
  const CreateCouponEvent(this.coupon);
  final Coupon coupon;
}
