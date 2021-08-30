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
  });

  factory BookingItem.fromJson(dynamic json) {
    DateTime? dtFrom =
        DateTime.tryParse(json['available_from_time'].toString());
    DateTime? dtTo = DateTime.tryParse(json['available_to_time'].toString());
    DateTime? startFrom = DateTime.tryParse(json['start_from'].toString());
    DateTime? endAt = DateTime.tryParse(json['end_at'].toString());

    return BookingItem(
      id: json['id'] as int,
      isActive: json['is_active'] as bool,
      poster: json['poster_url'].toString(),
      title: json['name'].toString(),
      location: json['location'] != null ? json['location'].toString() : null,
      availableFrom: dtFrom == null ? null : DateFormat.yMd().format(dtFrom),
      availableTo: dtTo == null ? null : DateFormat.yMd().format(dtTo),
      startFrom: startFrom == null ? null : DateFormat.yMd().format(startFrom),
      endAt: endAt == null ? null : DateFormat.yMd().format(endAt),
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
  final String? startFrom;
  final String? endAt;
  final bool? isPreserveable;
  final bool? isTransferable;
  final bool? isCountable;
  final bool? isDiscountable;
  final int? maxTransfer;
  final int? maxBook;
  final int? preservedBook;
  final int? creditPoints;
  final int? quantity;
  final double? discountAmount;
}
