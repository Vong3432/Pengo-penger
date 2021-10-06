import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:penger/bloc/booking-categories/booking_category_repo.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/response_model.dart';

part 'edit_booking_category_event.dart';
part 'edit_booking_category_state.dart';

class EditBookingCategoryBloc
    extends Bloc<EditBookingCategoryEvent, EditBookingCategoryState> {
  EditBookingCategoryBloc() : super(BookingCategoryUpdateInitial());

  final BookingCategoryRepo _repo = BookingCategoryRepo();

  @override
  Stream<EditBookingCategoryState> mapEventToState(
    EditBookingCategoryEvent event,
  ) async* {
    debugPrint(event.toString());
    // TODO: implement mapEventToState
    if (event is UpdateBookingCategoryEvent) {
      yield* _mapUpdateBookingCategoryToState(event.category);
    }
  }

  Stream<EditBookingCategoryState> _mapUpdateBookingCategoryToState(
      BookingCategory category) async* {
    try {
      yield BookingCategoryUpdating();
      final ResponseModel response =
          await _repo.updateBookingCategory(category);
      yield BookingCategoryUpdated(response);
    } catch (e) {
      yield BookingCategoryNotUpdated(e);
    }
  }
}
