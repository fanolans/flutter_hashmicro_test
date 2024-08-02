import '../repositories/attendance_repository.dart';
import '../entities/attendance.dart';

class CreateAttendance {
  final AttendanceRepository repository;

  CreateAttendance(this.repository);

  Future<void> call(Attendance attendance) {
    return repository.createAttendance(attendance);
  }
}
