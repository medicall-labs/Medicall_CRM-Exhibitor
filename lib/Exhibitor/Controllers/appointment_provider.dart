import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Constants/api_collection.dart';
import '../Screens/bottom_nav_bar.dart';
import '../Services/remote_services.dart';

class AppointmentProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  appointmentData(eventId) async {
    try {
      var appointmentResponse = await RemoteService()
          .getDataFromApi('${requestBaseUrl}/events/${eventId}/appointments');
      if (appointmentResponse["status"] == 'success') {
        return appointmentResponse;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }

  eventDates(eventId) async {
    try {
      var statusResponse = await RemoteService()
          .getDataFromApi('$requestBaseUrl/event-dates?event_id=$eventId');
      if (statusResponse["status"] == 'success') {
        return statusResponse;
      }
    } catch (err) {
      print(err);
    }
  }

  actionStatus(eventId, appId, status, data) async {
    try {
      var bodyContent;
      if (status == 'completed')
        bodyContent = {"status": "completed", "feedback": data};
      else {
        bodyContent = {"status": status};
      }
      var statusResponse = await RemoteService().postDataToApi(
          '$requestBaseUrl/events/$eventId/appointments/$appId', bodyContent);
      var result = jsonDecode(statusResponse.body);
      if (result["status"] == 'success') {
        Get.offAll(() => BottomNavBar(
              currentPage: 1,
            ));
        return result;
      }
    } catch (err) {
      print(err);
    }
  }

  actionRescheduled(eventId, appId, date, time) async {
    try {
      var bodyContent;
      bodyContent = {
        "status": "rescheduled",
        "date": date,
        "time": time,
      };
      print('................................');
      print(bodyContent);
      var statusResponse = await RemoteService().postDataToApi(
          '$requestBaseUrl/events/$eventId/appointments/$appId', bodyContent);
      var result = jsonDecode(statusResponse.body);
      print('................................');
      print(result);
      if (result["status"] == 'success') {
        Get.offAll(() => BottomNavBar(
              currentPage: 1,
            ));
        return result;
      }
    } catch (err) {
      print(err);
    }
  }
}
