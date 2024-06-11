import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../Constants/api_collection.dart';
import '../Services/remote_services.dart';

class AppointmentProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  eventData(eventId) async {
    try {
      var appointmentResponse = await RemoteService().getDataFromApi(
          '${requestBaseUrl}/events/${eventId}/appointments');
      if (appointmentResponse["status"] == 'success') {
        return appointmentResponse;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }

}
