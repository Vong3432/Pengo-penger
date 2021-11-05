part of 'booking_close_date_bloc.dart';

abstract class BookingCloseDateState extends Equatable {
  const BookingCloseDateState();

  @override
  List<Object> get props => [];
}

class BookingCloseDateListInitial extends BookingCloseDateState {}

class BookingCloseDateListLoading extends BookingCloseDateState {}

class BookingCloseDateListLoaded extends BookingCloseDateState {
  const BookingCloseDateListLoaded(this.list);
  final List<BookingCloseDate> list;
}

class BookingCloseDateListNotLoaded extends BookingCloseDateState {}

class BookingCloseDateInitial extends BookingCloseDateState {}

class BookingCloseDateLoading extends BookingCloseDateState {}

class BookingCloseDateLoaded extends BookingCloseDateState {
  const BookingCloseDateLoaded(this.date);
  final BookingCloseDate date;
}

class BookingCloseDateNotLoaded extends BookingCloseDateState {}

class BookingCloseDateAddInitial extends BookingCloseDateState {}

class BookingCloseDateAdding extends BookingCloseDateState {}

class BookingCloseDateAdded extends BookingCloseDateState {
  const BookingCloseDateAdded(this.response);

  final ResponseModel response;
}

class BookingCloseDateNotAdded extends BookingCloseDateState {
  const BookingCloseDateNotAdded(this.e);

  final Object? e;
}

class BookingCloseDateUpdateInitial extends BookingCloseDateState {}

class BookingCloseDateUpdating extends BookingCloseDateState {}

class BookingCloseDateUpdated extends BookingCloseDateState {
  const BookingCloseDateUpdated(this.response);

  final ResponseModel response;
}

class BookingCloseDateNotUpdated extends BookingCloseDateState {
  const BookingCloseDateNotUpdated(this.e);

  final Object? e;
}
