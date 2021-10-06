import 'package:penger/bloc/booking-categories/booking_category_api_provider.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/response_model.dart';

class BookingCategoryRepo {
  factory BookingCategoryRepo() {
    return _instance;
  }

  BookingCategoryRepo._constructor();

  static final BookingCategoryRepo _instance =
      BookingCategoryRepo._constructor();
  final BookingCategoryApiProvider _bookingCategoryApiProvider =
      BookingCategoryApiProvider();

  Future<List<BookingCategory>> fetchBookingCategories() async =>
      _bookingCategoryApiProvider.fetchBookingCategories();

  Future<BookingCategory> fetchBookingCategory(int id) async =>
      _bookingCategoryApiProvider.fetchBookingCategory(id);

  Future<ResponseModel> addBookingCategory(BookingCategory category) async =>
      _bookingCategoryApiProvider.addBookingCategory(category);

  Future<ResponseModel> updateBookingCategory(BookingCategory category) async =>
      _bookingCategoryApiProvider.updateBookingCategory(category);
}
