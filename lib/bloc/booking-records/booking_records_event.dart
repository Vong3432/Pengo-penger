part of 'booking_records_bloc.dart';

abstract class BookingRecordsEvent extends Equatable {
  const BookingRecordsEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingRecords extends BookingRecordsEvent {
  const FetchBookingRecords({
    required this.showToday,
    required this.showExpired,
  });

  final bool showToday;
  final bool showExpired;
}

class FetchBookingRecord extends BookingRecordsEvent {
  const FetchBookingRecord({
    required this.id,
  });

  final int id;
}
