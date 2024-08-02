import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/attendance/data/datasources/attendance_data_source_impl.dart';
import '../features/attendance/data/repositories/attendance_repository_impl.dart';
import '../features/attendance/domain/usecases/create_attendance.dart';
import '../features/attendance/presentation/blocs/attendance/attendance_bloc.dart';
import '../features/attendance/presentation/blocs/location/location_bloc.dart';
import '../utils/database_helper.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LocationBloc>(
    create: (context) => LocationBloc(
      DatabaseHelper(),
    ),
  ),
  BlocProvider<AttendanceBloc>(
    create: (context) => AttendanceBloc(
      CreateAttendance(
        AttendanceRepositoryImpl(
          AttendanceDataSourceImpl(),
        ),
      ),
    ),
  ),
];
