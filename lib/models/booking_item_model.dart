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
}

final List<BookingItem> bookingItemsMockData = <BookingItem>[
  const BookingItem(
    isActive: true,
    id: 9999,
    title: 'Durian Party Night',
    location: 'Impian Emas',
    price: 5.00,
    poster:
        "https://res.cloudinary.com/dpjso4bmh/image/upload/v1626869043/pengo/penger/logo/ie2lz02i7f5w6eqysvnm.png",
  ),
];
