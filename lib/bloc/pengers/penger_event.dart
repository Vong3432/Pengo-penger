part of 'penger_bloc.dart';

abstract class PengerEvent extends Equatable {
  const PengerEvent();

  @override
  List<Object?> get props => [];
}

class FetchPengers extends PengerEvent {
  const FetchPengers();
}

class FetchPopularNearestPengers extends PengerEvent {
  const FetchPopularNearestPengers();
}

class FetchPenger extends PengerEvent {
  const FetchPenger(this.id);

  final int id;
}

class CreatePenger extends PengerEvent {
  const CreatePenger({
    required this.name,
    required this.poster,
    this.description,
    required this.locationName,
    required this.lat,
    required this.lng,
  });

  final String name;
  final XFile poster;
  final String? description;
  final String locationName;
  final double lat;
  final double lng;
}

class UpdatePenger extends PengerEvent {
  const UpdatePenger({
    required this.id,
    required this.name,
    this.poster,
    this.description,
    required this.locationName,
    required this.lat,
    required this.lng,
  });

  final int id;
  final String name;
  final XFile? poster;
  final String? description;
  final String locationName;
  final double lat;
  final double lng;
}
