import 'package:penger/bloc/booking-items/booking_item_api_provider.dart';
import 'package:penger/models/booking_item_model.dart';

class BookingItemRepo {
  factory BookingItemRepo() {
    return _instance;
  }

  BookingItemRepo._constructor();

  static final BookingItemRepo _instance = BookingItemRepo._constructor();
  final BookingItemApiProvider _bookingItemApiProvider =
      BookingItemApiProvider();

  Future<List<BookingItem>> fetchBookingItems({int? catId}) async =>
      _bookingItemApiProvider.fetchBookingItems(catId: catId);
}