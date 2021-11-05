part of 'booking_close_date_bloc.dart';

abstract class BookingCloseDateEvent extends Equatable {
  const BookingCloseDateEvent();

  @override
  List<Object> get props => [];
}

class FetchCloseDates extends BookingCloseDateEvent {}

class DeleteCloseDate extends BookingCloseDateEvent {
  const DeleteCloseDate(this.id);

  final int id;
}

class AddCloseDate extends BookingCloseDateEvent {
  const AddCloseDate({
    required this.name,
    required this.from,
    required this.to,
    required this.keyId,
    required this.type,
  });

  final String name;
  final String from;
  final String to;
  final int keyId;
  final CloseDateType type;
}

class UpdateCloseDate extends BookingCloseDateEvent {
  const UpdateCloseDate({
    required this.name,
    required this.from,
    required this.to,
    required this.keyId,
    required this.type,
    required this.id,
  });

  final int id;
  final String name;
  final String from;
  final String to;
  final int keyId;
  final CloseDateType type;
}
