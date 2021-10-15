import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:penger/bloc/booking-items/booking_item_repo.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/models/response_model.dart';

part 'create_booking_item_event.dart';
part 'create_booking_item_state.dart';

class CreateBookingBloc
    extends Bloc<CreateBookingItemEvent, CreateBookingItemState> {
  CreateBookingBloc() : super(AddBookingItemInitial());

  final BookingItemRepo _repo = BookingItemRepo();

  @override
  Stream<CreateBookingItemState> mapEventToState(
    CreateBookingItemEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AddBookingItemEvent) {
      yield* _mapAddItemToState(event.itemModel);
    }
  }

  Stream<CreateBookingItemState> _mapAddItemToState(
      BookingItemModel model) async* {
    try {
      yield AddBookingItemLoading();
      debugPrint("Calling");
      final ResponseModel response = await _repo.addBookingItem(model);
      debugPrint("Responsed");
      await Future.delayed(const Duration(seconds: 1));
      debugPrint("Done");
      yield AddBookingItemSuccess(response);
    } catch (e) {
      yield AddBookingItemFailed(e);
    }
  }
}
