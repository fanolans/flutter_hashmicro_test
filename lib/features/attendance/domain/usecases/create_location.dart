import '../repositories/location_repository.dart';
import '../entities/location.dart';

class CreateLocation {
  final LocationRepository repository;

  CreateLocation(this.repository);

  Future<void> call(Location location) {
    return repository.createLocation(location);
  }
}
