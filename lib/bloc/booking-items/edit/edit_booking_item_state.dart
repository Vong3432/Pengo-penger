part of 'edit_booking_item_bloc.dart';

abstract class EditBookingItemState extends Equatable {
  const EditBookingItemState();
  @override
  List<Object> get props => [];
}

class EditBookingItemInitial extends EditBookingItemState {}

class EditBookingItemLoading extends EditBookingItemState {}

class EditBookingItemSuccess extends EditBookingItemState {
  const EditBookingItemSuccess(this.response);
  final ResponseModel response;
}

class EditBookingItemFailed extends EditBookingItemState {
  const EditBookingItemFailed(this.e);
  final Object e;
}
