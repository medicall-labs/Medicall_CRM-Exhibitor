import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medicall_exhibitor/Exhibitor/Screens/bottom_nav_bar.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/register_event.dart';

import '../../Constants/api_collection.dart';
import 'local_data.dart';

class AuthenticationProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  //Login
  void loginUser({
    required String mobileNumber,
    required String password,
    required bool otp,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String value;
    if (otp == true) {
      value = "yes";
    } else {
      value = "no";
    }
    final body = {
      "mobile_number": mobileNumber,
      "password": password,
      "is_otp_login": value
    };
    try {
      final uri = Uri.parse('$requestBaseUrl/login');
      var response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(body));
      var result = jsonDecode(response.body);
      if (result["status"] == "success") {
        GetStorage().write("local_store", result);
        _isLoading = false;
        _resMessage = "Login successfull!";
        notifyListeners();
        print(result);

        ///Save users data and then navigate to homepage
        final eventId = result['current_event_id'];
        final token = result['token'];
        LocalDataProvider().saveToken(token);
        LocalDataProvider().saveEventId(eventId);
        if (result["current_event"] == "Registered") {
          Get.offAll(() => BottomNavBar());
        } else {
          Get.offAll(() => EventRegistration());
        }
      } else {
        _resMessage = result['message'];
        print(result);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  otp(data) async {
    try {
      final uri = Uri.parse('$requestBaseUrl/otp-request');
      var apiBody = {"mobile_number": data};
      var response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(apiBody));
      return jsonDecode(response.body);
    } catch (err) {
      return null;
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
