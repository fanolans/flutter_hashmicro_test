import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../data/models/location_model.dart';
import '../pages/attendance_page.dart';

class ListLocationWidget extends StatelessWidget {
  const ListLocationWidget({
    super.key,
    required this.locations,
  });

  final List<LocationModel> locations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 16, top: 10, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'List Location Area',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text('Please refresh & select a location to take attendance'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return ListTile(
                leading: Icon(FluentIcons.building_people_16_filled),
                title: Text(location.name),
                subtitle: Text('${location.latitude}, ${location.longitude}'),
                trailing: Icon(FluentIcons.chevron_circle_right_16_regular),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(location: location),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
