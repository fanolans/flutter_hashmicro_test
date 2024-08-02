import 'package:equatable/equatable.dart';

import '../../../data/models/location_model.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LoadLocations extends LocationEvent {}

class AddLocation extends LocationEvent {
  final LocationModel location;

  const AddLocation(this.location);

  @override
  List<Object> get props => [location];
}
