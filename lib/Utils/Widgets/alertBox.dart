import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Exhibitor/Controllers/appointment_provider.dart';

void showDialogBox(BuildContext context, String title, String contextText,int eventId, int appointmentId ,String status) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title,),
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
              Provider.of<AppointmentProvider>(context, listen: false)
                  .actionStatus(eventId,appointmentId,status,'');
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}
