import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:penger/bloc/booking-items/booking_item_repo.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/providers/booking_item_model.dart';
import 'package:penger/models/response_model.dart';

part 'view_booking_item_event.dart';
part 'view_booking_item_state.dart';

class ViewItemBloc extends Bloc<ViewBookingItemEvent, ViewBookingItemState> {
  ViewItemBloc() : super(BookingItemInitial());

  final BookingItemRepo _repo = BookingItemRepo();

  @override
  Stream<ViewBookingItemState> mapEventToState(
    ViewBookingItemEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FetchBookingItemsEvent) {
      yield* _mapFetchItemsToState(catId: event.catId, name: event.name);
    }
    if (event is FetchBookingItemEvent) {
      yield* _mapFetchItem(event.itemId);
    }
  }

  Stream<ViewBookingItemState> _mapFetchItemsToState(
      {int? catId, String? name}) async* {
    try {
      yield BookingItemsLoading();
      final List<BookingItem> items = await _repo.fetchBookingItems(
        catId: catId,
        name: name,
      );
      await Future.delayed(const Duration(seconds: 1));
      yield BookingItemsLoaded(items);
    } catch (_) {
      yield BookingItemsNotLoaded();
    }
  }

  Stream<ViewBookingItemState> _mapFetchItem(int itemId) async* {
    try {
      yield BookingItemLoading();
      final BookingItem item = await _repo.fetchBookingItem(id: itemId);
      Future.delayed(Duration(seconds: 2));
      debugPrint("fet: ${item.toJson()}");
      yield BookingItemLoaded(item);
    } catch (_) {
      yield BookingItemNotLoaded();
    }
  }
}
