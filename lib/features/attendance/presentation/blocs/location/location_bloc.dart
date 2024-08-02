import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/database_helper.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final DatabaseHelper databaseHelper;

  LocationBloc(this.databaseHelper) : super(LocationLoading()) {
    on<LoadLocations>(_onLoadLocations);
    on<AddLocation>(_onAddLocation);
  }

  Future<void> _onLoadLocations(
      LoadLocations event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      final locations = await databaseHelper.getLocations();
      emit(LocationLoaded(locations));
    } catch (e) {
      emit(LocationError('Failed to load locations'));
    }
  }

  Future<void> _onAddLocation(
      AddLocation event, Emitter<LocationState> emit) async {
    try {
      await databaseHelper.insertLocation(event.location);
      final locations = await databaseHelper.getLocations();
      emit(LocationLoaded(locations));
    } catch (e) {
      emit(LocationError('Failed to add location'));
    }
  }
}
