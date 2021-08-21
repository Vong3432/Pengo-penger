part of 'booking_item_bloc.dart';

abstract class BookingItemEvent extends Equatable {
  const BookingItemEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingItemsEvent extends BookingItemEvent {}

class FetchBookingItemEvent extends BookingItemEvent {}

class FetchBookingItemsByCategoriesEvent extends BookingItemEvent {
  const FetchBookingItemsByCategoriesEvent(this.catId);
  final int catId;
}
