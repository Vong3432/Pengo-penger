import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/booking_item_model.dart';
import 'package:penger/models/system_function_model.dart';

part 'booking_category_model.g.dart';

@JsonSerializable()
class BookingCategory {
  const BookingCategory({
    required this.isEnabled,
    required this.name,
    this.id,
    this.pengerId,
    this.bookingOptions,
    this.bookingItems,
  });

  factory BookingCategory.fromJson(Map<String, dynamic> json) =>
      _$BookingCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$BookingCategoryToJson(this);

  final int? id;

  @JsonKey(name: 'is_enable')
  final bool isEnabled;

  @JsonKey(name: 'penger_id', fromJson: null)
  final int? pengerId;

  final String name;

  @JsonKey(name: 'booking_items')
  final List<BookingItem>? bookingItems;

  @JsonKey(name: 'booking_options')
  final List<SystemFunction>? bookingOptions;
}
