part of 'edit_booking_option_bloc.dart';

abstract class EditBookingOptionState extends Equatable {
  const EditBookingOptionState();

  @override
  List<Object> get props => [];
}

class BookingOptionUpdateInitial extends EditBookingOptionState {}

class BookingOptionUpdating extends EditBookingOptionState {}

class BookingOptionUpdated extends EditBookingOptionState {
  const BookingOptionUpdated(this.response);
  final ResponseModel response;
}

class BookingOptionNotUpdated extends EditBookingOptionState {
  const BookingOptionNotUpdated(this.e);
  final Object e;
}
