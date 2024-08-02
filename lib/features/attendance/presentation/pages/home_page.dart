import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hashmicro_test/core/assets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../blocs/location/location_bloc.dart';
import '../blocs/location/location_event.dart';
import '../blocs/location/location_state.dart';
import '../widgets/list_location_widget.dart';
import 'location_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userCurrentLocationName = 'loading...';
  String _userCurrentLatlong = 'loading...';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    BlocProvider.of<LocationBloc>(context).add(LoadLocations());
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        setState(() {
          _userCurrentLocationName =
              '${placemark.locality}, ${placemark.country}';
          _userCurrentLatlong = ' ${position.latitude}, ${position.longitude}';
        });
      } else {
        setState(() {
          _userCurrentLocationName = 'Unknown location';
          _userCurrentLatlong =
              'Lat: ${position.latitude}, Long: ${position.longitude}';
        });
      }
    } catch (e) {
      setState(() {
        _userCurrentLocationName = 'Error fetching location';
        _userCurrentLatlong = 'Lat: 0.0, Long: 0.0';
      });
    }
  }

  Future<void> _refreshLocations() async {
    BlocProvider.of<LocationBloc>(context).add(LoadLocations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Attendance App'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshLocations,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, bottom: 10, top: 10, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Current Location:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$_userCurrentLocationName',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text('$_userCurrentLatlong'),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  if (state is LocationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LocationLoaded) {
                    return ListLocationWidget(locations: state.locations);
                  } else if (state is LocationError) {
                    return Center(
                      child: Text('Error: ${state.message}'),
                    );
                  }
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(Assets.noLocation),
                        ),
                        const Text('There is no location yet'),
                        const Text(
                          'Please add location first',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newLocation = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LocationPage(),
            ),
          );

          if (newLocation != null) {
            BlocProvider.of<LocationBloc>(context)
                .add(AddLocation(newLocation));
          }
        },
        child: const Icon(FluentIcons.location_add_16_filled),
      ),
    );
  }
}
