import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Constants/api_collection.dart';
import '../Screens/bottom_nav_bar.dart';
import '../Services/remote_services.dart';

class ProductsProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  productData(eventId) async {
    try {
      var appointmentResponse = await RemoteService()
          .getDataFromApi('${requestBaseUrl}/events/${eventId}/appointments');
      if (appointmentResponse["status"] == 'success') {
        return appointmentResponse;
      }
      return {};
    } catch (err) {
      print(err);
      return {};
    }
  }

  // actionRescheduled(eventId, appId, date, time) async {
  //   try {
  //     var bodyContent;
  //     bodyContent = {
  //       "status": "rescheduled",
  //       "date": date,
  //       "time": time,
  //     };
  //     var statusResponse = await RemoteService().postDataToApi(
  //         '$requestBaseUrl/events/$eventId/appointments/$appId', bodyContent);
  //     var result = jsonDecode(statusResponse.body);
  //     if (result["status"] == 'success') {
  //       Get.offAll(() => BottomNavBar(
  //             currentPage: 1,
  //           ));
  //       return result;
  //     }
  //   } catch (err) {
  //     print(err);
  //   }
  // }

  addImage(id, imageId) async {
    try {
      var bodyContent = {
        "product_image": [imageId],
      };
      var productResponse = await RemoteService()
          .postDataToApi('$requestBaseUrl/exhibitor/products/$id', bodyContent);
      var result = jsonDecode(productResponse.body);
      if (result["status"] == 'success') {
        GetStorage().remove("profileData");
        return result;
      }
    } catch (err) {
      print(err);
    }
  }
}
