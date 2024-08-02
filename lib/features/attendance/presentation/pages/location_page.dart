import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../utils/custom_toast.dart';
import '../../../../utils/database_helper.dart';
import '../../../../utils/debouncer.dart';
import '../../../../utils/loading_overlay.dart';
import '../../data/models/location_model.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final _nameController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _debouncer = Debouncer(second: 2);

  @override
  void dispose() {
    _debouncer.dispose();
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  Future<void> _fetchCoordinates(String locationName) async {
    LoadingOverlay.show(context);
    try {
      List<Location> locations = await locationFromAddress(locationName);
      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          _latitudeController.text = location.latitude.toString();
          _longitudeController.text = location.longitude.toString();
        });
      } else {
        setState(() {
          _latitudeController.text = '';
          _longitudeController.text = '';
        });
      }
    } catch (e) {
      CustomToast.error(
        context,
        title: 'Error',
        description: 'Error getting location: $e',
      );
    } finally {
      LoadingOverlay.hide();
    }
  }

  void _onLocationNameChanged(String value) {
    _debouncer.run(() {
      _fetchCoordinates(value);
    });
  }

  Future<void> _addLocation() async {
    final name = _nameController.text;
    final latitude = double.tryParse(_latitudeController.text) ?? 0.0;
    final longitude = double.tryParse(_longitudeController.text) ?? 0.0;

    if (name.isEmpty || latitude == 0.0 || longitude == 0.0) {
      return;
    }

    final location = LocationModel(
      id: DateTime.now().toString(),
      name: name,
      latitude: latitude,
      longitude: longitude,
    );

    await DatabaseHelper().insertLocation(location);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Location Name',
                hintText: 'Contoh: Jakarta',
              ),
              onChanged: _onLocationNameChanged,
            ),
            TextField(
              controller: _latitudeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Latitude'),
              enabled: false,
            ),
            TextField(
              controller: _longitudeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Longitude'),
              enabled: false,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addLocation,
              child: const Text('Save Location'),
            ),
          ],
        ),
      ),
    );
  }
}
