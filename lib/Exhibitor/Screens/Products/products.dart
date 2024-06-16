import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../../Constants/styles.dart';
import '../../../Utils/Widgets/shimmer.dart';
import '../../Controllers/local_data.dart';
import '../../Controllers/profile_provider.dart';
import '../bottom_nav_bar.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  late File _selectedImage = File('');

  Future<void> _pickImage(productId) async {
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
        await ProductsProvider().addProductImage(productId, base64Image);
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
        Get.offAll(BottomNavBar());
        Get.to(AllProducts());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        body: SingleChildScrollView(
          child: Consumer<LocalDataProvider>(
            builder: (context, localData, child) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: FutureBuilder(
                    future: Provider.of<ProfileProvider>(context, listen: false)
                        .profileData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            AppSpaces.verticalSpace40,
                            AppSpaces.verticalSpace20,
                            Skeleton(height: 40),
                            AppSpaces.verticalSpace20,
                            Skeleton(height: 100),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 100),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 100),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 100),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 100),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 100),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 100),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        var productPage = snapshot.data;
                        if (productPage != null &&
                            productPage is Map<String, dynamic>) {
                          var allProducts = productPage['data']['products'];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSpaces.verticalSpace40,
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 10),
                                child: Text('Add Products Images',
                                    style: AppTextStyles.header2),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                    itemCount: allProducts.length,
                                    itemBuilder: (context, index) {
                                      if (allProducts[index]['images'].length ==
                                          0)
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          margin: EdgeInsets.only(
                                              left: 15, bottom: 15),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _pickImage(
                                                      allProducts[index]['id']);
                                                },
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/images/Logo.png",
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Center(
                                                      child:
                                                      Container(
                                                        width: MediaQuery.of(context).size.width * 0.2,
                                                        child: FittedBox(
                                                          child:  Text(
                                                            'Add Image',
                                                            style: AppTextStyles
                                                                .whitelabel1,
                                                          ),
                                                        ),
                                                      ),

                                                    ),
                                                  ],
                                                ),
                                              ),
                                              AppSpaces.horizontalSpace10,
                                              Container(
                                                height:20,
                                                width: MediaQuery.of(context).size.width * 0.5,
                                                child: FittedBox(
                                                    alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    allProducts[index]['name'],
                                                    style: AppTextStyles.textBody,
                                                  )
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      else if (allProducts[index]['images']
                                              .length ==
                                          1)
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          margin: EdgeInsets.only(
                                              left: 15, bottom: 15),
                                          child: Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), // Same border radius as the container
                                                      child: Image.network(
                                                        allProducts[index]
                                                                ['images'][0]
                                                            ['path'],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
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
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    "Cancel"),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  await ProductsProvider().removeProductImage(
                                                                      allProducts[
                                                                              index]
                                                                          [
                                                                          'id'],
                                                                      allProducts[
                                                                              index]['images'][0]
                                                                          [
                                                                          'id']);
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
                                                                  Get.offAll(
                                                                      BottomNavBar());
                                                                  Get.to(
                                                                      AllProducts());
                                                                },
                                                                child: Text(
                                                                    "Delete"),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.remove_rounded,
                                                        size: 22,
                                                        color: AppColor.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              AppSpaces.horizontalSpace10,
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height:20,
                                                    width: MediaQuery.of(context).size.width * 0.6,
                                                    child: FittedBox(
                                                      alignment: Alignment.centerLeft,
                                                      child:   Text(
                                                        allProducts[index]['name'],
                                                        style:
                                                        AppTextStyles.textBody,
                                                      ),
                                                    ),
                                                  ),

                                                  AppSpaces.verticalSpace10,
                                                  GestureDetector(
                                                      onTap: () {
                                                        _pickImage(
                                                            allProducts[index]
                                                                ['id']);
                                                      },
                                                      child: Card(
                                                        elevation: 5,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child:
                                                          Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            child: FittedBox(
                                                              child:  Text(
                                                                'Add more',
                                                                style: AppTextStyles
                                                                    .whitelabel,
                                                              ),
                                                            ),
                                                          ),

                                                        ),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      else
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent),
                                            child: ExpansionTile(
                                                iconColor: AppColor.grey,
                                                textColor: AppColor.secondary,
                                                title: Row(
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.topRight,
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10), // Same border radius as the container
                                                            child:
                                                                Image.network(
                                                              allProducts[index]
                                                                      ['images']
                                                                  [0]['path'],
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      "Delete Image"),
                                                                  content: Text(
                                                                      "Are you sure you want to delete this image?"),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          "Cancel"),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await ProductsProvider().removeProductImage(
                                                                            allProducts[index]['id'],
                                                                            allProducts[index]['images'][0]['id']);
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierDismissible:
                                                                              false,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Center(
                                                                              child: CircularProgressIndicator(),
                                                                            );
                                                                          },
                                                                        );
                                                                        Future.delayed(Duration(
                                                                            seconds:
                                                                                5));
                                                                        Get.offAll(
                                                                            BottomNavBar());
                                                                        Get.to(
                                                                            AllProducts());
                                                                      },
                                                                      child: Text(
                                                                          "Delete"),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColor
                                                                  .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        5.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10.0),
                                                              ),
                                                            ),
                                                            child: Icon(
                                                              Icons
                                                                  .remove_rounded,
                                                              size: 22,
                                                              color: AppColor
                                                                  .black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    AppSpaces.horizontalSpace10,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height:20,
                                                          width: MediaQuery.of(context).size.width * 0.5,
                                                          child: FittedBox(
                                                            alignment: Alignment.centerLeft,
                                                            child:   Text(
                                                              allProducts[index]['name'],
                                                              style:
                                                              AppTextStyles.textBody,
                                                            ),
                                                          ),
                                                        ),
                                                        AppSpaces
                                                            .verticalSpace10,
                                                        GestureDetector(
                                                          onTap: () {
                                                            _pickImage(
                                                                allProducts[
                                                                        index]
                                                                    ['id']);
                                                          },
                                                          child: Card(
                                                            elevation: 5,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Container(
                                                                width: MediaQuery.of(context).size.width * 0.1,
                                                                child: FittedBox(
                                                                  child:  Text(
                                                                    'Add more',
                                                                    style: AppTextStyles
                                                                        .whitelabel,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                childrenPadding:
                                                    const EdgeInsets.only(
                                                        left: 15),
                                                children: [
                                                  Wrap(
                                                    spacing: 10,
                                                    runSpacing: 10,
                                                    children: [
                                                      for (int i = 1;
                                                          i <
                                                              allProducts[index]
                                                                      ['images']
                                                                  .length;
                                                          i++)
                                                        Stack(
                                                          alignment: Alignment
                                                              .topRight,
                                                          children: [
                                                            Container(
                                                              width: 100,
                                                              height: 100,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  allProducts[index]
                                                                          [
                                                                          'images']
                                                                      [
                                                                      i]['path'],
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          "Delete Image"),
                                                                      content: Text(
                                                                          "Are you sure you want to delete this image?"),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text("Cancel"),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await ProductsProvider().removeProductImage(allProducts[index]['id'],
                                                                                allProducts[index]['images'][i]['id']);
                                                                            Navigator.of(context).pop();
                                                                            showDialog(
                                                                              context: context,
                                                                              barrierDismissible: false,
                                                                              builder: (BuildContext context) {
                                                                                return Center(
                                                                                  child: CircularProgressIndicator(),
                                                                                );
                                                                              },
                                                                            );
                                                                            Future.delayed(Duration(seconds: 5));
                                                                            Get.offAll(BottomNavBar());
                                                                            Get.to(AllProducts());
                                                                          },
                                                                          child:
                                                                              Text("Delete"),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColor
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10.0),
                                                                  ),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .remove_rounded,
                                                                  size: 22,
                                                                  color: AppColor
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        );
                                    }),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: Text('No data available.'));
                        }
                      }
                    })),
          ),
        ));
  }
}
