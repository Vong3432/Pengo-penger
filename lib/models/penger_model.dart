import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/location_model.dart';

part 'penger_model.g.dart';

@JsonSerializable()
class Penger {
  const Penger({
    required this.id,
    required this.name,
    required this.logo,
    // this.items,
    required this.description,
    required this.location,
    // this.reviews,
  });

  factory Penger.fromJson(Map<String, dynamic> json) => _$PengerFromJson(json);
  Map<String, dynamic> toJson() => _$PengerToJson(this);

  final int id;
  final String name;
  final String logo;
  final String? description;
  final Location location;

  // @JsonKey(includeIfNull: false)
  // final List<Review>? reviews;

  // @JsonKey(includeIfNull: false)
  // final List<BookingItem>? items;
}
