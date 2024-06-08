import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = '';

  int _eventId = 0;

  String get token => _token;

  int get eventId => _eventId;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
  }

  void saveEventId(int id) async {
    SharedPreferences value = await _pref;

    value.setString('id', id as String);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<int> getEventId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('id')) {
      int data = value.getString('id')! as int;
      _eventId = data;
      notifyListeners();
      return data;
    } else {
      _eventId = 0;
      notifyListeners();
      return 0;
    }
  }

  void logOut(BuildContext context) async {
    final value = await _pref;
    value.clear();
  }
}