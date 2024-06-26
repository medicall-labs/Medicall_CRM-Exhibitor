import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../Constants/api_collection.dart';
import '../Services/remote_services.dart';

class EventProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  eventData(eventId) async {
    try {
      var eventResponse = await RemoteService()
          .getDataFromApi('${requestBaseUrl}/exhibitors/${eventId}/dashboard');
      if (eventResponse["status"] == 'success') {
        return eventResponse;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }

  announcements() async {
    try {
      var eventResponse = await RemoteService()
          .getDataFromApi('${requestBaseUrl}/announcements');
      if (eventResponse["status"] == 'success') {
        return eventResponse['data'];
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }
}
