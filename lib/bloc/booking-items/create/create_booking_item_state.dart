part of 'create_booking_item_bloc.dart';

abstract class CreateBookingItemState extends Equatable {
  const CreateBookingItemState();
  @override
  List<Object> get props => [];
}

class AddBookingItemInitial extends CreateBookingItemState {}

class AddBookingItemLoading extends CreateBookingItemState {}

class AddBookingItemSuccess extends CreateBookingItemState {
  const AddBookingItemSuccess(this.response);
  final ResponseModel response;
}

class AddBookingItemFailed extends CreateBookingItemState {
  const AddBookingItemFailed(this.e);
  final Object e;
}
