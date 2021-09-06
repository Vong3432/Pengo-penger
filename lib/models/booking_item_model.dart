import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class BookingItem {
  const BookingItem({
    required this.poster,
    required this.isActive,
    required this.title,
    required this.id,
    this.price,
    this.location,
    this.availableFrom,
    this.availableTo,
    this.startFrom,
    this.endAt,
    this.isPreserveable,
    this.isTransferable,
    this.isCountable,
    this.isDiscountable,
    this.maxTransfer,
    this.maxBook,
    this.preservedBook,
    this.creditPoints,
    this.quantity,
    this.discountAmount,
    this.categoryId,
    this.description,
  });

  factory BookingItem.fromJson(dynamic json) {
    DateTime? dtFrom =
        DateTime.tryParse(json['available_from_time'].toString());
    DateTime? dtTo = DateTime.tryParse(json['available_to_time'].toString());
    DateTime? startFrom = DateTime.tryParse(json['start_from'].toString());
    DateTime? endAt = DateTime.tryParse(json['end_at'].toString());

    debugPrint(json.toString());
    return BookingItem(
      id: json['id'] as int,
      categoryId: json['booking_category_id'] as int,
      isActive: json['is_active'] as bool,
      poster: json['poster_url'].toString(),
      title: json['name'].toString(),
      location:
          json['geolocation'] != null ? json['geolocation'].toString() : null,
      availableFrom: dtFrom == null ? null : DateFormat.yMd().format(dtFrom),
      availableTo: dtTo == null ? null : DateFormat.yMd().format(dtTo),
      startFrom: startFrom,
      endAt: endAt,
      description: json['description']?.toString(),
      price: json['price'] == null
          ? 0.0
          : double.tryParse(json['price'].toString()),
      creditPoints: json['credit_points'] == null
          ? 0.0
          : double.tryParse(json['credit_points'].toString()),
      discountAmount: json['discount_amount'] == null
          ? 0.0
          : double.tryParse(json['discount_amount'].toString()),
      isCountable: json['is_countable'] as bool,
      isDiscountable: json['is_discountable'] as bool,
      isTransferable: json['is_transferable'] as bool,
      isPreserveable: json['is_preservable'] as bool,
      maxTransfer: json['maximum_transfer'] == null
          ? 0
          : json['maximum_transfer'] as int,
      maxBook: json['maximum_book'] == null ? 0 : json['maximum_book'] as int,
      preservedBook:
          json['preserved_book'] == null ? 0 : json['preserved_book'] as int,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["is_active"] = isActive;
    map["title"] = title;
    map["poster"] = poster;
    map["location"] = location;
    map["is_preservable"] = isPreserveable;
    map["is_transferable"] = isTransferable;
    map["is_countable"] = isCountable;
    map["is_discountable"] = isDiscountable;
    map["quantity"] = quantity;
    map["discount_amount"] = discountAmount;
    map["credit_points"] = creditPoints;
    map["maximum_transfer"] = maxTransfer;
    map["maximum_book"] = maxBook;
    map["preserved_book"] = preservedBook;

    // Add all other fields
    return map;
  }

  final int id;
  final bool isActive;
  final String title;
  final String poster;
  final double? price;
  final String? location;
  final String? availableFrom;
  final String? availableTo;
  final DateTime? startFrom;
  final DateTime? endAt;
  final bool? isPreserveable;
  final bool? isTransferable;
  final bool? isCountable;
  final bool? isDiscountable;
  final int? maxTransfer;
  final int? maxBook;
  final int? preservedBook;
  final double? creditPoints;
  final int? quantity;
  final double? discountAmount;
  final int? categoryId;
  final String? description;
}
