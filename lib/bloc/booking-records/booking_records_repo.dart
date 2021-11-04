import 'package:penger/bloc/booking-records/booking_records_api_provider.dart';
import 'package:penger/models/booking_record_model.dart';

class BookingRecordsRepo {
  factory BookingRecordsRepo() {
    return _instance;
  }

  BookingRecordsRepo._constructor();

  static final BookingRecordsRepo _instance = BookingRecordsRepo._constructor();
  final BookingRecordApiProvider _bookingRecordApiProvider =
      BookingRecordApiProvider();

  Future<List<BookingRecord>> fetchRecords(
    bool showToday,
    bool showExpired,
  ) async =>
      _bookingRecordApiProvider.fetchRecords(showToday, showExpired);

  Future<BookingRecord> fetchRecord({required int id}) async =>
      _bookingRecordApiProvider.fetchBookingRecord(id: id);
}
