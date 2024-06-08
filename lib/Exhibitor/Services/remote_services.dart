import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:medicall_exhibitor/Constants/api_collection.dart';

class RemoteServices {
  var baseUrl = AppUrl.baseUrl;
  var tokenDetails = GetStorage().read("local_store") != ''
      ? GetStorage().read("local_store")
      : '';

}
