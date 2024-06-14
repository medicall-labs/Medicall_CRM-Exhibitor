import 'package:flutter/material.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../../Exhibitor/Controllers/appointment_provider.dart';

void showDialogBox(BuildContext context, String title, String contextText,
    int eventId, int appointmentId, String status) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
        ),
        content: Text(contextText),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (appointmentId != 5400) {
                Provider.of<AppointmentProvider>(context, listen: false)
                    .actionStatus(eventId, appointmentId, status, '');
              } else {
                Provider.of<DashboardProvider>(context, listen: false)
                    .eventRegister(eventId);
              }
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}
