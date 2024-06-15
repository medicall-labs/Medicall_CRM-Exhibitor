import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/My_Profile/profile.dart';
import '../../Constants/api_collection.dart';
import '../Models/profile_model.dart';
import '../Screens/bottom_nav_bar.dart';
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
        return profileResponse;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }

  editLogo(imgPath) async {
    try {
      var editedProfileLogo = {"exhibitor_logo": imgPath};
      var statusResponse = await RemoteService()
          .postDataToApi('$requestBaseUrl/exhibitor/logo', editedProfileLogo);
      var result = jsonDecode(statusResponse.body);
      if (result["status"] == 'success') {
        Get.offAll(() => BottomNavBar(
              currentPage: 1,
            ));
        Get.to(MyProfile());
        return result;
      }
    } catch (err) {}
  }

  editProfile(editedProfileData) async {
    try {
      var statusResponse = await RemoteService().postDataToApi(
          '$requestBaseUrl/exhibitor/profile/edit', editedProfileData);
      var result = jsonDecode(statusResponse.body);
      print("............................");print(result);
      if (result["status"] == 'success') {
        Get.offAll(() => BottomNavBar(
              currentPage: 1,
            ));
        Get.to(MyProfile());
        return result;
      }
    } catch (err) {
      print(err);
    }
  }
}
