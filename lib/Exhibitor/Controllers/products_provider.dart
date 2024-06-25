import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/My_Profile/profile.dart';
import '../../Constants/api_collection.dart';
import '../Screens/Products/products.dart';
import '../Screens/bottom_nav_bar.dart';
import '../Services/remote_services.dart';

class ProductsProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;

  addProductImage(id, imageId) async {
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

  removeProductImage(id, imageId) async {
    try {
      var productResponse = await RemoteService().postDataToApi(
          '$requestBaseUrl/exhibitor/products/$id/images/$imageId', '');
      var result = jsonDecode(productResponse.body);
      if (result["status"] == 'success') {
        GetStorage().remove("profileData");
        return result;
      }
    } catch (err) {
      print(err);
    }
  }

  productDetails(query) async {
    try {
      var productResponse = await RemoteService()
          .getDataFromApi('$requestBaseUrl/products/$query');
      if (productResponse["status"] == 'success') {
        return productResponse;
      }
    } catch (err) {
      print(err);
    }
  }

  addProductstoCurrentEvent(id, productId) async {
    try {
      var bodyContent = {
        "products": productId,
      };
      var productResponse = await RemoteService()
          .postDataToApi('$requestBaseUrl/events/$id/products', bodyContent);
      var result = jsonDecode(productResponse.body);
      if (result["status"] == 'success') {
        GetStorage().remove("profileData");
        Get.offAll(BottomNavBar());
        Get.to(MyProfile());
        return result;
      }
    } catch (err) {
      print(err);
    }
  }
}
