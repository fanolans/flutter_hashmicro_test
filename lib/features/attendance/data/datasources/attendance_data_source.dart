import '../models/attendance_model.dart';

abstract class AttendanceDataSource {
  Future<void> createAttendance(AttendanceModel attendance);
}
