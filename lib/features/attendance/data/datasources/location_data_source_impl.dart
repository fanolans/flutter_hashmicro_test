import 'package:flutter/foundation.dart';

import 'location_data_source.dart';
import '../models/location_model.dart';

class LocationDataSourceImpl implements LocationDataSource {
  final List<LocationModel> _locations = [];

  @override
  Future<void> createLocation(LocationModel location) async {
    _locations.add(location);
    if (kDebugMode) {
      print(
        'Location added: ${location.name} at (${location.latitude}, ${location.longitude})',
      );
    }
  }
}
