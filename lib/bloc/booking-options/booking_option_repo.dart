import 'package:penger/bloc/booking-options/booking_option_api_provider.dart';
import 'package:penger/models/response_model.dart';

class BookingOptionRepo {
  factory BookingOptionRepo() {
    return _instance;
  }

  BookingOptionRepo._constructor();

  static final BookingOptionRepo _instance = BookingOptionRepo._constructor();
  final BookingOptionApiProvider _bookingOptionApiProvider =
      BookingOptionApiProvider();

  Future<ResponseModel> updateBookingOption(
    int categoryId,
    List<int?> ids,
  ) async =>
      _bookingOptionApiProvider.updateBookingOption(categoryId, ids);
}
