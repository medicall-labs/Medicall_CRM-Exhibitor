import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../Constants/api_collection.dart';
import '../Services/remote_services.dart';

class HistoryProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  historyData() async {
    try {
      var historyResponse = await RemoteService()
          .getDataFromApi('${requestBaseUrl}/previous-events');
      if (historyResponse["status"] == 'success') {
        return historyResponse;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }

  previousAppointments(eventId) async {
    try {
      var previousHistoryResponse = await RemoteService()
          .getDataFromApi('${requestBaseUrl}/previous-events/$eventId');

      if (previousHistoryResponse["status"] == 'success') {
        return previousHistoryResponse;
      }
      return {};
    } catch (err) {
      print(err);
    }
  }
}
