import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<void> createAttendance(Attendance attendance);
}
