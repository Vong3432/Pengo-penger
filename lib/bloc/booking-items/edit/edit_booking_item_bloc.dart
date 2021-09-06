import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:penger/bloc/booking-items/booking_item_repo.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/models/response_model.dart';

part 'edit_booking_item_event.dart';
part 'edit_booking_item_state.dart';

class EditBookingItemBloc
    extends Bloc<UpdateBookingItemEvent, EditBookingItemState> {
  EditBookingItemBloc() : super(EditBookingItemInitial());

  final BookingItemRepo _repo = BookingItemRepo();

  @override
  Stream<EditBookingItemState> mapEventToState(
    UpdateBookingItemEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is EditBookingItemEvent) {
      yield* _mapEditItemToState(event.itemModel);
    }
  }

  Stream<EditBookingItemState> _mapEditItemToState(
      BookingItemModel model) async* {
    try {
      yield EditBookingItemLoading();
      final ResponseModel response = await _repo.editBookingItem(model);
      await Future.delayed(const Duration(seconds: 1));
      yield EditBookingItemSuccess(response);
    } catch (e) {
      yield EditBookingItemFailed(e);
    }
  }
}
