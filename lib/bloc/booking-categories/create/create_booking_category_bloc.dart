import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:penger/bloc/booking-categories/booking_category_repo.dart';
import 'package:penger/models/booking_category_model.dart';
import 'package:penger/models/response_model.dart';

part 'create_booking_category_event.dart';
part 'create_booking_category_state.dart';

class CreateBookingCategoryBloc
    extends Bloc<CreateBookingCategoryEvent, CreateBookingCategoryState> {
  CreateBookingCategoryBloc() : super(BookingCategoryAddInitial());

  final BookingCategoryRepo _repo = BookingCategoryRepo();

  @override
  Stream<CreateBookingCategoryState> mapEventToState(
    CreateBookingCategoryEvent event,
  ) async* {
    debugPrint(event.toString());
    // TODO: implement mapEventToState
    if (event is AddBookingCategoryEvent) {
      yield* _mapAddBookingCategoryToState(event.category);
    }
  }

  Stream<CreateBookingCategoryState> _mapAddBookingCategoryToState(
      BookingCategory category) async* {
    try {
      yield BookingCategoryAdding();
      final ResponseModel response = await _repo.addBookingCategory(category);
      yield BookingCategoryAdded(response);
    } catch (e) {
      yield BookingCategoryNotAdded(e);
    }
  }
}
