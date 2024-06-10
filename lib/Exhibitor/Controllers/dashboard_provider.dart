import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../Constants/api_collection.dart';
import '../Services/remote_services.dart';

class DashboardProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  dashboardData(eventId) async {
    try {
      var dashboardResponse = await RemoteService().getDataFromApi(
          'https://crm.medicall.in/api/dashboard?event_id=$eventId');
      if (dashboardResponse["status"] == 'success') {
        return dashboardResponse;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
