import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../../Constants/api_collection.dart';
import '../Models/profile_model.dart';
import '../Services/remote_services.dart';

class ProfileProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  late Future<ProfileModel?> profileModelFuture;
  profileData() async {
    try {
      var profileResponse = await RemoteService()
          .getDataFromApi('${requestBaseUrl}/exhibitor/profile');
      if (profileResponse["status"] == 'success') {
        ProfileModel profileModel = ProfileModel.fromJson(profileResponse);
        GetStorage().write("profileData", profileResponse);
        return profileModel;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }
}
