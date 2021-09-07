import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/booking_item_model.dart';

part 'booking_category_model.g.dart';

@JsonSerializable()
class BookingCategory {
  const BookingCategory({
    required this.isEnabled,
    required this.name,
    required this.id,
    this.bookingItems,
  });

  // factory BookingCategory.fromJson(dynamic json) {
  //   List<BookingItem> bookingItemList = (json['booking_items'] as List)
  //       .map((i) => BookingItem.fromJson(i))
  //       .toList();
  //   return BookingCategory(
  //     id: json['id'] as int,
  //     isEnabled: json['is_enable'] as bool,
  //     name: json['name'].toString(),
  //     bookingItems: bookingItemList,
  //   );
  // }

  factory BookingCategory.fromJson(Map<String, dynamic> json) =>
      _$BookingCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$BookingCategoryToJson(this);

  final int id;

  @JsonKey(name: 'is_enable')
  final bool isEnabled;

  final String name;
  final List<BookingItem>? bookingItems;
}
