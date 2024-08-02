import 'package:flutter/foundation.dart';

import 'attendance_data_source.dart';
import '../models/attendance_model.dart';

class AttendanceDataSourceImpl implements AttendanceDataSource {
  final List<AttendanceModel> _attendances = [];

  @override
  Future<void> createAttendance(AttendanceModel attendance) async {
    _attendances.add(attendance);
    if (kDebugMode) {
      print(
        'Attendance added for user ${attendance.userName} at (${attendance.latitude}, ${attendance.longitude})',
      );
    }
  }
}
