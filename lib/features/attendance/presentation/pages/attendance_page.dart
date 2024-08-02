import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../utils/custom_toast.dart';
import '../../../../utils/debouncer.dart';
import '../../../../utils/loading_overlay.dart';
import '../../data/models/location_model.dart';
import '../../domain/entities/attendance.dart';
import '../blocs/attendance/attendance_bloc.dart';
import '../blocs/attendance/attendance_event.dart';
import '../blocs/attendance/attendance_state.dart';

class AttendancePage extends StatefulWidget {
  final LocationModel location;

  const AttendancePage({Key? key, required this.location}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final _userNameController = TextEditingController();
  final _debouncer = Debouncer(second: 2);
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    } catch (e) {
      if (mounted) {
        CustomToast.error(
          context,
          title: 'Error',
          description: 'Error getting your current location: $e',
        );
      }
    }
  }

  Future<void> _addAttendance() async {
    if (_currentPosition != null && _userNameController.text.isNotEmpty) {
      final attendance = Attendance(
        id: DateTime.now().toString(),
        userName: _userNameController.text,
        locationId: widget.location.id,
        timestamp: DateTime.now(),
        latitude: _currentPosition!.latitude,
        longitude: _currentPosition!.longitude,
      );

      final distance = Geolocator.distanceBetween(
        widget.location.latitude,
        widget.location.longitude,
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      if (distance <= 50) {
        LoadingOverlay.show(context);

        BlocProvider.of<AttendanceBloc>(context).add(AddAttendance(attendance));
      } else {
        CustomToast.warning(
          context,
          title: 'Warning',
          description: 'You are too far from the pin location',
        );
      }
    } else {
      CustomToast.error(
        context,
        title: 'Error',
        description:
            'Please enter your name and ensure location permission is available',
      );
    }
  }

  void _onUserNameChanged(String value) {
    _debouncer.run(() {});
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Attendance')),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceLoading) {
            LoadingOverlay.show(context);
          } else if (state is AttendanceSuccess) {
            LoadingOverlay.hide();
            CustomToast.success(
              context,
              title: 'Success',
              description: 'Attendance Success',
            );
            Navigator.pop(context);
          } else if (state is AttendanceFailure) {
            LoadingOverlay.hide();
            CustomToast.error(
              context,
              title: 'Error',
              description: 'Attendance Failure',
            );
          }
        },
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Location: ${widget.location.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: _userNameController,
                  decoration: const InputDecoration(labelText: 'Your Name'),
                  onChanged: _onUserNameChanged,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _addAttendance,
                    child: const Text('Submit Attendance'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
