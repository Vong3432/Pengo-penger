part of 'edit_booking_category_bloc.dart';

abstract class EditBookingCategoryEvent extends Equatable {
  const EditBookingCategoryEvent();

  @override
  List<Object> get props => [];
}

class UpdateBookingCategoryEvent extends EditBookingCategoryEvent {
  const UpdateBookingCategoryEvent(this.category);
  final BookingCategory category;
}
