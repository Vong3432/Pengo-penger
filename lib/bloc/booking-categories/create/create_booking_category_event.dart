part of 'create_booking_category_bloc.dart';

abstract class CreateBookingCategoryEvent extends Equatable {
  const CreateBookingCategoryEvent();

  @override
  List<Object> get props => [];
}

class AddBookingCategoryEvent extends CreateBookingCategoryEvent {
  const AddBookingCategoryEvent(this.category);
  final BookingCategory category;
}
