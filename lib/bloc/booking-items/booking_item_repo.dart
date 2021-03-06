import 'package:penger/bloc/booking-items/booking_item_api_provider.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/models/response_model.dart';

class BookingItemRepo {
  factory BookingItemRepo() {
    return _instance;
  }

  BookingItemRepo._constructor();

  static final BookingItemRepo _instance = BookingItemRepo._constructor();
  final BookingItemApiProvider _bookingItemApiProvider =
      BookingItemApiProvider();

  Future<List<BookingItem>> fetchBookingItems(
          {int? catId, String? name}) async =>
      _bookingItemApiProvider.fetchBookingItems(catId: catId, name: name);

  Future<BookingItem> fetchBookingItem({required int id}) async =>
      _bookingItemApiProvider.fetchBookingItem(id: id);

  Future<ResponseModel> addBookingItem(BookingItemModel model) async =>
      _bookingItemApiProvider.addBookingItem(model);

  Future<ResponseModel> editBookingItem(BookingItemModel model) async =>
      _bookingItemApiProvider.editBookingItem(model);
}
