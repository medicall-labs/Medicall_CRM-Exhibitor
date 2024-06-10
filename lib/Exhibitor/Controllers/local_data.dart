import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocalDataProvider extends ChangeNotifier {
  int eventId = 0;

  void changeEventID(int id) {
    eventId = id;
    notifyListeners();
  }
}

// Future<int> fetchEventId() async {
//   // Simulate a network request
//   await Future.delayed(Duration(seconds: 2));
//   eventId = 17; // Simulated fetched data
//   notifyListeners();
//   return eventId;
// }
