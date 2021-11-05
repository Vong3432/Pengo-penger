import 'package:penger/bloc/booking-close-dates/booking_close_date_api_provider.dart';
import 'package:penger/bloc/booking-close-dates/booking_close_date_bloc.dart';
import 'package:penger/bloc/staff/staff_api_provider.dart';
import 'package:penger/models/booking_close_date_model.dart';
import 'package:penger/models/response_model.dart';
import 'package:penger/models/user_model.dart';

class BookingCloseDateRepo {
  factory BookingCloseDateRepo() {
    return _instance;
  }

  BookingCloseDateRepo._constructor();

  static final BookingCloseDateRepo _instance =
      BookingCloseDateRepo._constructor();
  final BookingCloseDateApiProvider _bookingCloseDateApiProvider =
      BookingCloseDateApiProvider();

  Future<List<BookingCloseDate>> fetchCloseDates() async =>
      _bookingCloseDateApiProvider.fetchCloseDates();

  Future<ResponseModel> createCloseDate({
    required String name,
    required String from,
    required String to,
    required int keyId,
    required CloseDateType type,
  }) async =>
      _bookingCloseDateApiProvider.createCloseDate(
        name: name,
        to: to,
        from: from,
        keyId: keyId,
        type: type,
      );

  Future<ResponseModel> updateCloseDate({
    required String name,
    required String from,
    required String to,
    required int keyId,
    required CloseDateType type,
    required int id,
  }) async =>
      _bookingCloseDateApiProvider.updateCloseDate(
        id: id,
        name: name,
        to: to,
        from: from,
        keyId: keyId,
        type: type,
      );

  Future<void> delCloseDate(int id) async =>
      _bookingCloseDateApiProvider.delCloseDate(id);
}
