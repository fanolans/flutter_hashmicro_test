import 'package:flutter/material.dart';
import '../features/attendance/data/models/location_model.dart';
import '../features/attendance/presentation/pages/attendance_page.dart';
import '../features/attendance/presentation/pages/home_page.dart';
import '../features/attendance/presentation/pages/location_page.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomePage(),
  '/location': (context) => const LocationPage(),
  '/attendance': (context) {
    final LocationModel location =
        ModalRoute.of(context)!.settings.arguments as LocationModel;
    return AttendancePage(location: location);
  },
};
