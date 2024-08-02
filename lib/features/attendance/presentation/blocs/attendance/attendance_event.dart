import 'package:equatable/equatable.dart';
import '../../../domain/entities/attendance.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class AddAttendance extends AttendanceEvent {
  final Attendance attendance;

  const AddAttendance(this.attendance);

  @override
  List<Object> get props => [attendance];
}
