import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/products_provider.dart';
import 'package:provider/provider.dart';
import '../../../Constants/app_color.dart';
import '../../Controllers/profile_provider.dart';
import '../../Models/profile_model.dart';
import '../bottom_nav_bar.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late File _selectedImage = File('');
  bool show = false;

  void initState() {
    super.initState();
    setState(() {});
  }

  Future<void> _pickImage(productId) async {
    show = true;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      bool saveImage = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Save Image?'),
            content: Text('Do you want to save the selected image?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );

      if (saveImage) {
        String base64Image = base64Encode(_selectedImage.readAsBytesSync());
        await Provider.of<ProductsProvider>(context, listen: false)
            .addImage(productId, base64Image);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        await Future.delayed(Duration(seconds: 5));
        Get.offAll(BottomNavBar(currentPage: 3));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      ProfileProvider().profileModelFuture;
    });
    return Scaffold(
      body: FutureBuilder<ProfileModel?>(
          future: ProfileProvider().profileModelFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var productDetails = snapshot.data;
              if (productDetails != null) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: AppColor.primary,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Row(children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColor.black,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "All Products",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColor.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ]),
                      ),
                      Expanded(
                          child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: ListView.builder(
                          itemCount: productDetails.data?.products?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: ListTile(
                                title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.66,
                                                child: Text(
                                                  "${productDetails.data?.products?[index].name.toString()}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _pickImage(productDetails.data
                                                      ?.products?[index].id);
                                                },
                                                child: Icon(
                                                  Icons.add_a_photo,
                                                  color: AppColor.secondary,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          for (int i = 0;
                                              i <
                                                  (productDetails
                                                          .data
                                                          ?.products?[index]
                                                          .images
                                                          ?.length ??
                                                      0);
                                              i++)
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  height: 150,
                                                  width: 150,
                                                  child: Image.network(
                                                    productDetails
                                                            .data
                                                            ?.products?[index]
                                                            .images![i]
                                                            .path
                                                            .toString() ??
                                                        ' ',
                                                    fit: BoxFit.fill,
                                                    height: 120,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.26,
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: AppColor.secondary,
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Delete Image"),
                                                          content: Text(
                                                              "Are you sure you want to delete this image?"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Close the dialog
                                                              },
                                                              child: Text(
                                                                  "Cancel"),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                // setState(() {
                                                                //   productCtrl.removeImage(
                                                                //       productDetails
                                                                //           .data
                                                                //           ?.products?[
                                                                //               index]
                                                                //           .id,
                                                                //       productDetails
                                                                //           .data
                                                                //           ?.products?[
                                                                //               index]
                                                                //           .images![
                                                                //               i]
                                                                //           .id);
                                                                // });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      false,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    );
                                                                  },
                                                                );
                                                                Future.delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            5));
                                                                Get.offAll(() => BottomNavBar(
                                                                              currentPage: 3
                                                                            ));
                                                              },
                                                              child: Text(
                                                                  "Delete"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ]),
                              ),
                            );
                          },
                        ),
                      ))
                    ],
                  ),
                );
              } else {
                return Center(child: const Text('No data available.'));
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.secondary,
        onPressed: () {
          // Get.to(() => AddProduct());
        },
        tooltip: 'Add products to current event',
        child: Icon(Icons.add),
      ),
    );
  }
}
