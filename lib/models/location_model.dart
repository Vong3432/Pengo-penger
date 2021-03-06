import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/geolocation_model.dart';

part 'location_model.g.dart';

@JsonSerializable()
class Location {
  const Location({
    required this.geolocation,
    this.name,
    this.address,
    this.street,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  final Geolocation geolocation;
  final String? name;
  final String? address;
  final String? street;
}
