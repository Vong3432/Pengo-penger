import 'package:penger/models/booking_item_model.dart';

class BookingCategory {
  const BookingCategory({
    required this.isEnabled,
    required this.name,
    required this.id,
    this.bookingItems,
  });

  factory BookingCategory.fromJson(dynamic json) {
    List<BookingItem> bookingItemList = (json['booking_items'] as List)
        .map((i) => BookingItem.fromJson(i))
        .toList();
    return BookingCategory(
      id: json['id'] as int,
      isEnabled: json['is_enable'] as bool,
      name: json['name'].toString(),
      bookingItems: bookingItemList,
    );
  }

  final int id;
  final bool isEnabled;
  final String name;
  final List<BookingItem>? bookingItems;
}
