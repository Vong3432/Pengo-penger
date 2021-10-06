part of 'edit_booking_option_bloc.dart';

abstract class EditBookingOptionEvent extends Equatable {
  const EditBookingOptionEvent();

  @override
  List<Object> get props => [];
}

class UpdateBookingOptionEvent extends EditBookingOptionEvent {
  const UpdateBookingOptionEvent(this.categoryId, this.systemFunctions);
  final int categoryId;
  final List<SystemFunction> systemFunctions;
}
