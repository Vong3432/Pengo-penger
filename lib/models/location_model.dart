class Location {
  const Location(
      {required this.lat,
      required this.lng,
      required this.location,
      required this.street});

  factory Location.fromJson(dynamic json) {
    return Location(
      location: json['address'].toString(),
      street: json['street'].toString(),
      lat: json['geolocation']['latitude'] as double,
      lng: json['geolocation']['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["location"] = location;
    map["street"] = street;
    map["lat"] = lat;
    map["lng"] = lng;
    // Add all other fields
    return map;
  }

  final String location;
  final String street;
  final double lat;
  final double lng;
}
