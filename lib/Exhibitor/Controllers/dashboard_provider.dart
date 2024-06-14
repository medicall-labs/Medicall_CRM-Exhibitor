import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../Constants/api_collection.dart';
import '../Screens/bottom_nav_bar.dart';
import '../Services/remote_services.dart';

class DashboardProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  dashboardData() async {
    try {
      var dashboardResponse =
          await RemoteService().getDataFromApi('${requestBaseUrl}/dashboard');
      if (dashboardResponse["status"] == 'success') {
        return dashboardResponse;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }

  eventRegister(eventId) async {
    try {
      var statusResponse = await RemoteService().postDataToApi(
          '$requestBaseUrl/events/$eventId/exhibitor/registration', '');
      var result = jsonDecode(statusResponse.body);
      if (result["status"] == 'success') {
        Get.offAll(() => BottomNavBar(
          currentPage: 2,
        ));
        return result;
      }
    } catch (err) {
      print(err);
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
