import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/booking-records/booking_records_repo.dart';
import 'package:penger/models/booking_record_model.dart';

part 'booking_records_event.dart';
part 'booking_records_state.dart';

class BookingRecordsBloc
    extends Bloc<BookingRecordsEvent, BookingRecordsState> {
  BookingRecordsBloc() : super(BookingRecordsInitial()) {
    on<FetchBookingRecords>(_fetchBookingRecords);
    on<FetchBookingRecord>(_fetchBookingRecord);
  }

  final BookingRecordsRepo _repo = BookingRecordsRepo();

  Future<void> _fetchBookingRecords(
    FetchBookingRecords event,
    Emitter<BookingRecordsState> emit,
  ) async {
    try {
      emit(BookingRecordsLoading());
      final List<BookingRecord> records =
          await _repo.fetchRecords(event.showToday, event.showExpired);
      emit(BookingRecordsLoaded(records));
    } catch (e) {
      emit(BookingRecordsNotLoaded(e));
    }
  }

  Future<void> _fetchBookingRecord(
    FetchBookingRecord event,
    Emitter<BookingRecordsState> emit,
  ) async {
    try {
      emit(BookingRecordLoading());
      final BookingRecord record = await _repo.fetchRecord(id: event.id);
      emit(BookingRecordLoaded(record));
    } catch (e) {
      emit(BookingRecordNotLoaded(e));
    }
  }
}
