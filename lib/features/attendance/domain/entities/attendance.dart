class Attendance {
  final String id;
  final String userName;
  final String locationId;
  final DateTime timestamp;
  final double latitude;
  final double longitude;

  Attendance({
    required this.id,
    required this.userName,
    required this.locationId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
  });
}
