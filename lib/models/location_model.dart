import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/geolocation_model.dart';

part 'location_model.g.dart';

@JsonSerializable()
class Location {
  const Location({required this.geolocation});

  // factory Location.fromJson(dynamic json) {
  //   return Location(
  //     location: json['address'].toString(),
  //     street: json['street'].toString(),
  //     lat: json['geolocation']['latitude'] as double,
  //     lng: json['geolocation']['longitude'] as double,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   map["location"] = location;
  //   map["street"] = street;
  //   map["lat"] = lat;
  //   map["lng"] = lng;
  //   // Add all other fields
  //   return map;
  // }

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  final Geolocation geolocation;
}
