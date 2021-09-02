import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:penger/bloc/booking-items/booking_item_repo.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/models/response_model.dart';

part 'booking_item_event.dart';
part 'booking_item_state.dart';

class BookingItemBloc extends Bloc<BookingItemEvent, BookingItemState> {
  BookingItemBloc() : super(BookingItemInitial());

  final BookingItemRepo _repo = BookingItemRepo();

  @override
  Stream<BookingItemState> mapEventToState(
    BookingItemEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchBookingItemsEvent) {
      yield* _mapFetchItemsToState();
    }
    if (event is FetchBookingItemsByCategoriesEvent) {
      yield* _mapFetchItemsByCatToState(event.catId);
    }
    if (event is AddBookingItemEvent) {
      yield* _mapAddItemToState(event.itemModel);
    }
  }

  Stream<BookingItemState> _mapAddItemToState(BookingItemModel model) async* {
    try {
      yield AddBookingItemLoading();
      final ResponseModel response = await _repo.addBookingItem(model);
      await Future.delayed(const Duration(seconds: 1));
      yield AddBookingItemSuccess(response);
    } catch (e) {
      yield AddBookingItemFailed(e);
    }
  }

  Stream<BookingItemState> _mapFetchItemsToState() async* {
    try {
      yield BookingItemsLoading();
      final List<BookingItem> items = await _repo.fetchBookingItems();
      await Future.delayed(const Duration(seconds: 1));
      yield BookingItemsLoaded(items);
    } catch (_) {
      yield BookingItemsNotLoaded();
    }
  }

  Stream<BookingItemState> _mapFetchItemsByCatToState(int catId) async* {
    try {
      yield BookingItemsLoading();
      final List<BookingItem> items =
          await _repo.fetchBookingItems(catId: catId);
      yield BookingItemsLoaded(items);
    } catch (_) {
      yield BookingItemsNotLoaded();
    }
  }
}
