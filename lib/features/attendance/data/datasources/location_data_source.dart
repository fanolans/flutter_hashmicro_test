import '../models/location_model.dart';

abstract class LocationDataSource {
  Future<void> createLocation(LocationModel location);
}
