part of 'create_booking_category_bloc.dart';

abstract class CreateBookingCategoryState extends Equatable {
  const CreateBookingCategoryState();

  @override
  List<Object> get props => [];
}

class BookingCategoryAddInitial extends CreateBookingCategoryState {}

class BookingCategoryAdding extends CreateBookingCategoryState {}

class BookingCategoryAdded extends CreateBookingCategoryState {
  const BookingCategoryAdded(this.response);
  final ResponseModel response;
}

class BookingCategoryNotAdded extends CreateBookingCategoryState {
  const BookingCategoryNotAdded(this.e);
  final Object e;
}
