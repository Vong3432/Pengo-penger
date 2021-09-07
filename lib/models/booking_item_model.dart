import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/geolocation_model.dart';

part 'booking_item_model.g.dart';

@JsonSerializable()
class BookingItem {
  BookingItem({
    required this.poster,
    required this.isActive,
    required this.title,
    required this.id,
    this.price,
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
    this.geolocation,
  });

  // factory BookingItem.fromJson(dynamic json) {
  //   DateTime? dtFrom =
  //       DateTime.tryParse(json['available_from_time'].toString());
  //   DateTime? dtTo = DateTime.tryParse(json['available_to_time'].toString());
  //   DateTime? startFrom = DateTime.tryParse(json['start_from'].toString());
  //   DateTime? endAt = DateTime.tryParse(json['end_at'].toString());

  //   debugPrint(json.toString());
  //   return BookingItem(
  //     id: json['id'] as int,
  //     categoryId: json['booking_category_id'] as int,
  //     isActive: json['is_active'] as bool,
  //     poster: json['poster_url'].toString(),
  //     title: json['name'].toString(),
  //     location:
  //         json['geolocation'] != null ? json['geolocation'].toString() : null,
  //     availableFrom: dtFrom == null ? null : DateFormat.yMd().format(dtFrom),
  //     availableTo: dtTo == null ? null : DateFormat.yMd().format(dtTo),
  //     startFrom: startFrom,
  //     endAt: endAt,
  //     description: json['description']?.toString(),
  //     price: json['price'] == null
  //         ? 0.0
  //         : double.tryParse(json['price'].toString()),
  //     creditPoints: json['credit_points'] == null
  //         ? 0.0
  //         : double.tryParse(json['credit_points'].toString()),
  //     discountAmount: json['discount_amount'] == null
  //         ? 0.0
  //         : double.tryParse(json['discount_amount'].toString()),
  //     isCountable: json['is_countable'] as bool,
  //     isDiscountable: json['is_discountable'] as bool,
  //     isTransferable: json['is_transferable'] as bool,
  //     isPreserveable: json['is_preservable'] as bool,
  //     maxTransfer: json['maximum_transfer'] == null
  //         ? 0
  //         : json['maximum_transfer'] as int,
  //     maxBook: json['maximum_book'] == null ? 0 : json['maximum_book'] as int,
  //     preservedBook:
  //         json['preserved_book'] == null ? 0 : json['preserved_book'] as int,
  //     quantity: json['quantity'] as int,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["id"] = id;
  //   map["is_active"] = isActive;
  //   map["title"] = title;
  //   map["poster"] = poster;
  //   map["location"] = location;
  //   map["is_preservable"] = isPreserveable;
  //   map["is_transferable"] = isTransferable;
  //   map["is_countable"] = isCountable;
  //   map["is_discountable"] = isDiscountable;
  //   map["quantity"] = quantity;
  //   map["discount_amount"] = discountAmount;
  //   map["credit_points"] = creditPoints;
  //   map["maximum_transfer"] = maxTransfer;
  //   map["maximum_book"] = maxBook;
  //   map["preserved_book"] = preservedBook;

  //   // Add all other fields
  //   return map;
  // }

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    final BookingItem t = _$BookingItemFromJson(json);
    if (t.geolocation != null) {
      t.location = t.geolocation!.name;
    }
    return t;
  }
  Map<String, dynamic> toJson() => _$BookingItemToJson(this);

  final int id;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'name')
  final String title;

  @JsonKey(name: 'poster_url')
  final String poster;

  final double? price;

  @JsonKey(ignore: true, fromJson: null, toJson: null)
  String? location;

  @JsonKey(name: 'available_from', includeIfNull: false)
  final String? availableFrom;

  @JsonKey(name: 'available_to', includeIfNull: false)
  final String? availableTo;

  @JsonKey(name: 'start_from', includeIfNull: false)
  final DateTime? startFrom;

  @JsonKey(name: 'end_at', includeIfNull: false)
  final DateTime? endAt;

  @JsonKey(name: 'is_preservable')
  final bool? isPreserveable;

  @JsonKey(name: 'is_transferable')
  final bool? isTransferable;

  @JsonKey(name: 'is_countable')
  final bool? isCountable;

  @JsonKey(name: 'is_discountable')
  final bool? isDiscountable;

  @JsonKey(name: 'maximum_transfer')
  final int? maxTransfer;

  @JsonKey(name: 'maximum_book')
  final int? maxBook;

  @JsonKey(name: 'preserved_book')
  final int? preservedBook;

  @JsonKey(name: 'credit_points')
  final double? creditPoints;

  final int? quantity;

  @JsonKey(name: 'discount_amount')
  final double? discountAmount;

  @JsonKey(name: 'booking_category_id')
  final int? categoryId;

  @JsonKey(includeIfNull: false)
  final String? description;

  @JsonKey(name: 'geolocation', includeIfNull: false)
  final Geolocation? geolocation;
}
