part of 'view_booking_category_bloc.dart';

abstract class ViewBookingCategoryState extends Equatable {
  const ViewBookingCategoryState();

  @override
  List<Object> get props => [];
}

class BookingCategoriesInitial extends ViewBookingCategoryState {}

class BookingCategoriesLoading extends ViewBookingCategoryState {}

class BookingCategoriesLoaded extends ViewBookingCategoryState {
  const BookingCategoriesLoaded(this.categories);
  final List<BookingCategory> categories;
}

class BookingCategoriesNotLoaded extends ViewBookingCategoryState {}

class BookingCategoryInitial extends ViewBookingCategoryState {}

class BookingCategoryLoading extends ViewBookingCategoryState {}

class BookingCategoryLoaded extends ViewBookingCategoryState {
  const BookingCategoryLoaded(this.category);
  final BookingCategory category;
}

class BookingCategoryNotLoaded extends ViewBookingCategoryState {}
