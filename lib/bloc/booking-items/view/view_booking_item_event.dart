part of 'view_booking_item_bloc.dart';

abstract class ViewBookingItemEvent extends Equatable {
  const ViewBookingItemEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingItemsEvent extends ViewBookingItemEvent {
  const FetchBookingItemsEvent({this.catId, this.name});

  final int? catId;
  final String? name;
}

class FetchBookingItemEvent extends ViewBookingItemEvent {
  const FetchBookingItemEvent(this.itemId);
  final int itemId;
}
