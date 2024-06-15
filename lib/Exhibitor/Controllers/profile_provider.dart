import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/My_Profile/profile.dart';
import '../../Constants/api_collection.dart';
import '../../Constants/app_color.dart';
import '../../Utils/Widgets/snack_bar.dart';
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
        ProfileModel.fromJson(profileResponse);
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
        Get.offAll(() => BottomNavBar());
        Get.to(MyProfile());
        return result;
      }

    } catch (err) {}
  }

  editProfile(BuildContext context,editedProfileData) async {
    try {
      var statusResponse = await RemoteService().postDataToApi(
          '$requestBaseUrl/exhibitor/profile/edit', editedProfileData);
      var result = jsonDecode(statusResponse.body);
      if (result["status"] == 'success') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  title: const Text('Profile Edited Successfully'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                            color: AppColor.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]);
            });
        Get.offAll(() => BottomNavBar());
        Get.to(MyProfile());
        return result;
      }
      else{
        showMessage(
            backgroundColor: Colors.red,
            mainMessage: result["message"],
            secondaryMessage:
            result['errors'].toString(),
            context: context);
      }
    } catch (err) {
      print(err);
    }
  }
}
