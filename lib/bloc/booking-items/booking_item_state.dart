part of 'booking_item_bloc.dart';

abstract class BookingItemState extends Equatable {
  const BookingItemState();

  @override
  List<Object> get props => [];
}

class BookingItemInitial extends BookingItemState {}

class BookingItemLoading extends BookingItemState {}

class BookingItemLoaded extends BookingItemState {}

class BookingItemNotLoaded extends BookingItemState {}

class BookingItemsInitial extends BookingItemState {}

class BookingItemsLoading extends BookingItemState {}

class BookingItemsLoaded extends BookingItemState {
  const BookingItemsLoaded(this.items);

  final List<BookingItem> items;
}

class BookingItemsNotLoaded extends BookingItemState {}

class AddBookingItemInitial extends BookingItemState {}

class AddBookingItemLoading extends BookingItemState {}

class AddBookingItemSuccess extends BookingItemState {
  const AddBookingItemSuccess(this.response);
  final ResponseModel response;
}

class AddBookingItemFailed extends BookingItemState {
  const AddBookingItemFailed(this.e);
  final Object e;
}
