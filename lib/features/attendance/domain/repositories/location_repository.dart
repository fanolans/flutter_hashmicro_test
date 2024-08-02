import '../entities/location.dart';

abstract class LocationRepository {
  Future<void> createLocation(Location location);
}
