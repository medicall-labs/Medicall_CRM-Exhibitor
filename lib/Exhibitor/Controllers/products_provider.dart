import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Constants/api_collection.dart';
import '../../Utils/Widgets/snack_bar.dart';
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
