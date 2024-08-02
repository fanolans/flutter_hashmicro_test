import '../../domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
  });

  factory LocationModel.fromMap(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
