part of 'create_booking_item_bloc.dart';

abstract class CreateBookingItemEvent extends Equatable {
  const CreateBookingItemEvent();

  @override
  List<Object> get props => [];
}

class AddBookingItemEvent extends CreateBookingItemEvent {
  const AddBookingItemEvent(this.itemModel);
  final BookingItemModel itemModel;
}
