import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_data_source.dart';
import '../models/attendance_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDataSource dataSource;

  AttendanceRepositoryImpl(this.dataSource);

  @override
  Future<void> createAttendance(Attendance attendance) {
    return dataSource.createAttendance(AttendanceModel(
      id: attendance.id,
      userName: attendance.userName,
      locationId: attendance.locationId,
      timestamp: attendance.timestamp,
      latitude: attendance.latitude,
      longitude: attendance.longitude,
    ));
  }
}
