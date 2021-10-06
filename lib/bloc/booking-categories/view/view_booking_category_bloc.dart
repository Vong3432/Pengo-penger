import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:penger/bloc/booking-categories/booking_category_repo.dart';
import 'package:penger/models/booking_category_model.dart';

part 'view_booking_category_event.dart';
part 'view_booking_category_state.dart';

class ViewBookingCategoryBloc
    extends Bloc<ViewBookingCategoryEvent, ViewBookingCategoryState> {
  ViewBookingCategoryBloc() : super(BookingCategoryInitial());

  final BookingCategoryRepo _repo = BookingCategoryRepo();

  @override
  Stream<ViewBookingCategoryState> mapEventToState(
    ViewBookingCategoryEvent event,
  ) async* {
    debugPrint(event.toString());
    // TODO: implement mapEventToState
    if (event is FetchBookingCategoriesEvent) {
      yield* _mapFetchCategoriesToState();
    }
    if (event is FetchBookingCategoryEvent) {
      yield* _mapFetchCategoryToState(event.id);
    }
  }

  Stream<ViewBookingCategoryState> _mapFetchCategoriesToState() async* {
    try {
      yield BookingCategoriesLoading();
      final List<BookingCategory> categories =
          await _repo.fetchBookingCategories();
      yield BookingCategoriesLoaded(categories);
    } catch (_) {
      yield BookingCategoriesNotLoaded();
    }
  }

  Stream<ViewBookingCategoryState> _mapFetchCategoryToState(int id) async* {
    try {
      yield BookingCategoryLoading();
      final BookingCategory category = await _repo.fetchBookingCategory(id);
      yield BookingCategoryLoaded(category);
    } catch (_) {
      yield BookingCategoryNotLoaded();
    }
  }
}
