import 'package:json_annotation/json_annotation.dart';
import 'package:penger/models/user_model.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  const Review({
    required this.id,
    required this.title,
    required this.date,
    this.description,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
  final int id;
  final String title;
  final User user;
  final String date;
  final String? description;
}
