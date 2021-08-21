import 'package:penger/models/user_model.dart';

class Review {
  const Review({
    required this.id,
    required this.title,
    required this.date,
    this.description,
    required this.user,
  });

  factory Review.fromJson(dynamic json) {
    return Review(
      id: json['id'] as int,
      title: json['name'].toString(),
      description: json['location'].toString(),
      user: User.fromJson(
        json['user'],
      ),
      date: json['created_at'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = title;
    map["user"] = user.toMap();
    map["date"] = date;
    map["description"] = description;
    // Add all other fields
    return map;
  }

  final int id;
  final String title;
  final User user;
  final String date;
  final String? description;
}
