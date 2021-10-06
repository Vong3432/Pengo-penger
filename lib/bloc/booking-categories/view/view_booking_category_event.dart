part of 'view_booking_category_bloc.dart';

abstract class ViewBookingCategoryEvent extends Equatable {
  const ViewBookingCategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingCategoriesEvent extends ViewBookingCategoryEvent {}

class FetchBookingCategoryEvent extends ViewBookingCategoryEvent {
  const FetchBookingCategoryEvent(this.id);
  final int id;
}
