part of 'booking_records_bloc.dart';

abstract class BookingRecordsState extends Equatable {
  const BookingRecordsState();

  @override
  List<Object> get props => [];
}

class BookingRecordsInitial extends BookingRecordsState {}

class BookingRecordsLoading extends BookingRecordsState {}

class BookingRecordsLoaded extends BookingRecordsState {
  const BookingRecordsLoaded(this.records);

  final List<BookingRecord> records;
}

class BookingRecordsNotLoaded extends BookingRecordsState {
  const BookingRecordsNotLoaded(this.e);

  final Object? e;
}

class BookingRecordInitial extends BookingRecordsState {}

class BookingRecordLoading extends BookingRecordsState {}

class BookingRecordLoaded extends BookingRecordsState {
  const BookingRecordLoaded(this.record);

  final BookingRecord record;
}

class BookingRecordNotLoaded extends BookingRecordsState {
  const BookingRecordNotLoaded(this.e);

  final Object? e;
}
