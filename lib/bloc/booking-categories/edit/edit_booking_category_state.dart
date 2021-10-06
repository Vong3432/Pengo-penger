part of 'edit_booking_category_bloc.dart';

abstract class EditBookingCategoryState extends Equatable {
  const EditBookingCategoryState();

  @override
  List<Object> get props => [];
}

class BookingCategoryUpdateInitial extends EditBookingCategoryState {}

class BookingCategoryUpdating extends EditBookingCategoryState {}

class BookingCategoryUpdated extends EditBookingCategoryState {
  const BookingCategoryUpdated(this.response);
  final ResponseModel response;
}

class BookingCategoryNotUpdated extends EditBookingCategoryState {
  const BookingCategoryNotUpdated(this.e);
  final Object e;
}
