import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_data_source.dart';
import '../models/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<void> createLocation(Location location) {
    return dataSource.createLocation(LocationModel(
      id: location.id,
      name: location.name,
      latitude: location.latitude,
      longitude: location.longitude,
    ));
  }
}
