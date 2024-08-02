import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/create_attendance.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final CreateAttendance createAttendance;

  AttendanceBloc(this.createAttendance) : super(AttendanceInitial()) {
    on<AddAttendance>(_onAddAttendance);
  }

  Future<void> _onAddAttendance(
      AddAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      await createAttendance(event.attendance);
      emit(AttendanceSuccess());
    } catch (_) {
      emit(AttendanceFailure());
    }
  }
}
