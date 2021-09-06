part of 'edit_booking_item_bloc.dart';

abstract class UpdateBookingItemEvent extends Equatable {
  const UpdateBookingItemEvent();

  @override
  List<Object> get props => [];
}

class EditBookingItemEvent extends UpdateBookingItemEvent {
  const EditBookingItemEvent(this.itemModel);
  final BookingItemModel itemModel;
}
