import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class LocalDataProvider extends ChangeNotifier {
  late Map<String, dynamic> userDetails;
  late int eventId;

  LocalDataProvider() {
    var storedData = GetStorage().read("local_store");
    if (storedData != null && storedData != '') {
      userDetails = storedData;
      eventId = userDetails['current_event_id'] ?? 0;  // default value if key doesn't exist
    } else {
      userDetails = {};
      eventId = 0;  // default value when no stored data is found
    }
  }

  void changeEventID(int id) {
    eventId = id;
    notifyListeners();
  }
}


// old code
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
//
// class LocalDataProvider extends ChangeNotifier {
//
//   final UserDetails = GetStorage().read("local_store") != ''
//       ? GetStorage().read("local_store")
//       : '';
//   int eventId = 0;
//
//   void changeEventID(int id) {
//     eventId = id;
//     notifyListeners();
//   }
// }
