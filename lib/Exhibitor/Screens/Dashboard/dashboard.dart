import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:medicall_exhibitor/Constants/spacing.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/dashboard_provider.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../Constants/app_color.dart';
import '../../../Constants/styles.dart';
import '../../../Utils/Identity/identity.dart';
import '../../../Utils/Widgets/alertBox.dart';
import '../../../Utils/Widgets/shimmer.dart';
import '../../Controllers/auth_provider.dart';
import '../../Controllers/local_data.dart';
import '../My_History/history.dart';
import '../My_Profile/profile.dart';
import '../Products/products.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final UserDetails = GetStorage().read("local_store") != ''
      ? GetStorage().read("local_store")
      : '';

  final profileLogo = GetStorage().read("profileData") != ''
      ? GetStorage().read("profileData")
      : '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<LocalDataProvider>(
      builder: (context, localData, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: FutureBuilder(
              future: Provider.of<DashboardProvider>(context, listen: false)
                  .dashboardData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      AppSpaces.verticalSpace40,
                      Skeleton(height: 40),
                      AppSpaces.verticalSpace20,
                      Skeleton(height: 30),
                      AppSpaces.verticalSpace10,
                      Skeleton(height: 200),
                      AppSpaces.verticalSpace40,
                      Skeleton(height: 80),
                      AppSpaces.verticalSpace15,
                      Skeleton(height: 80),
                      AppSpaces.verticalSpace15,
                      Skeleton(height: 80),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  var registerEventPage = snapshot.data;
                  if (registerEventPage != null &&
                      registerEventPage is Map<String, dynamic>) {
                    var myDeviations = registerEventPage['data'];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpaces.verticalSpace40,
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.grey[200],
                                child: profileLogo['data']['logo'] != ''
                                    ? ClipOval(
                                        child: Image.network(
                                            profileLogo['data']['logo'],
                                            fit: BoxFit.cover),
                                      )
                                    : Container()),
                            AppSpaces.horizontalSpace10,
                            Text('Dashboard', style: AppTextStyles.header2),
                            Spacer(),
                            CustomTextWidget(),
                            PopupMenuButton(
                              icon: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  AppColor.secondary,
                                  BlendMode.modulate,
                                ),
                                child: Container(
                                    height: 30,
                                    child: Lottie.asset(
                                        'assets/lottie/menu.json')),
                              ),
                              color: Colors.white,
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(
                                          Icons.person,
                                          color:
                                          AppColor.black.withOpacity(0.5),
                                          size: 20,
                                        ),
                                      ),
                                      AppSpaces.horizontalSpace20,
                                      Text(
                                        'My Profile',
                                        style: AppTextStyles.label,
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(
                                          Icons.shopping_cart_outlined,
                                          color:
                                          AppColor.black.withOpacity(0.5),
                                          size: 20,
                                        ),
                                      ),
                                      AppSpaces.horizontalSpace20,
                                      Text(
                                        'Products',
                                        style: AppTextStyles.label,
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 3,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(
                                          Icons.history_rounded,
                                          color:
                                          AppColor.black.withOpacity(0.5),
                                          size: 20,
                                        ),
                                      ),
                                      AppSpaces.horizontalSpace20,
                                      Text(
                                        'My History',
                                        style: AppTextStyles.label,
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 4,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(
                                          Icons.logout,
                                          color:
                                          AppColor.black.withOpacity(0.5),
                                          size: 20,
                                        ),
                                      ),
                                      AppSpaces.horizontalSpace20,
                                      Text(
                                        'Logout',
                                        style: AppTextStyles.label,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                if (value == 1) {
                                  Get.to(() => MyProfile());
                                } else if (value == 2) {
                                  Get.to(AllProducts());
                                } else if (value == 3) {
                                  Get.to(() => MyHistory());
                                } else if (value == 4) {
                                  AuthenticationProvider().logout();
                                }
                              },
                            ),
                          ],
                        ),
                        AppSpaces.verticalSpace20,
                        Text(
                          'Current Event',
                          style: AppTextStyles.header4,
                        ),
                        AppSpaces.verticalSpace10,
                        GestureDetector(
                          onTap: () {
                            if (registerEventPage['data']['currentEvent']
                                    ['registrationStatus'] ==
                                "Registered") {
                              Provider.of<LocalDataProvider>(context,
                                      listen: false)
                                  .changeEventID(registerEventPage['data']
                                      ['currentEvent']['id']);
                              Get.offAll(BottomNavBar());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 10,
                                      right: 0,
                                      child: Container(
                                        width: 100,
                                        child: ClipRect(
                                          clipBehavior: Clip.antiAlias,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            heightFactor: 0.6,
                                            child: Image.network(
                                              registerEventPage['data']
                                                  ['currentEvent']['thumbnail'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: ClipRect(
                                        clipBehavior: Clip.antiAlias,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          heightFactor: 0.4,
                                          child: Image.network(
                                            registerEventPage['data']
                                                ['currentEvent']['thumbnail'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        registerEventPage['data']
                                            ['currentEvent']['title'],
                                        style: AppTextStyles.label6,
                                      ),
                                      if (registerEventPage['data']
                                                  ['currentEvent']
                                              ['registrationStatus'] ==
                                          "Register")
                                        GestureDetector(
                                          onTap: () {
                                            showDialogBox(
                                              context,
                                              'Confirm Action',
                                              'Are you sure you want to register this event?',
                                              registerEventPage['data']
                                                  ['currentEvent']['id'],
                                              5400,
                                              '',
                                            );
                                          },
                                          child: Card(
                                            elevation: 5,
                                            child: Container(
                                              height: 30,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.green),
                                              child: Center(
                                                child: Text(
                                                  'Register',
                                                  style:
                                                      AppTextStyles.whitelabel,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (registerEventPage['data']
                                                  ['currentEvent']
                                              ['registrationStatus'] !=
                                          "Register")
                                        Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.blue),
                                          child: Center(
                                            child: Text(
                                              'Registered',
                                              style: AppTextStyles.whitelabel,
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        AppSpaces.verticalSpace40,
                        Text(
                          'Upcoming Event',
                          style: AppTextStyles.header4,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: registerEventPage['data']
                                    ['upcomingEvents']
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  if (registerEventPage['data']
                                              ['upcomingEvents'][index]
                                          ['registrationStatus'] ==
                                      "Registered") {
                                    Provider.of<LocalDataProvider>(context,
                                            listen: false)
                                        .changeEventID(registerEventPage['data']
                                            ['upcomingEvents'][index]['id']);
                                    Get.offAll(BottomNavBar());
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 80,
                                        child: Image.network(
                                          registerEventPage['data']
                                                  ['upcomingEvents'][index]
                                              ['thumbnail'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            registerEventPage['data']
                                                    ['upcomingEvents'][index]
                                                ['title'],
                                            style: AppTextStyles.label6,
                                          ),
                                          if (registerEventPage['data']
                                                      ['upcomingEvents'][index]
                                                  ['registrationStatus'] ==
                                              "Register")
                                            GestureDetector(
                                              onTap: () {
                                                showDialogBox(
                                                  context,
                                                  'Confirm Action',
                                                  'Are you sure you want to register this event?',
                                                  registerEventPage['data']
                                                          ['upcomingEvents']
                                                      [index]['id'],
                                                  5400,
                                                  '',
                                                );
                                              },
                                              child: Card(
                                                elevation: 5,
                                                child: Container(
                                                  height: 30,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.green),
                                                  child: Center(
                                                    child: Text(
                                                      'Register',
                                                      style: AppTextStyles
                                                          .whitelabel,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (registerEventPage['data']
                                                      ['upcomingEvents'][index]
                                                  ['registrationStatus'] !=
                                              "Register")
                                            Container(
                                              height: 30,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.blue),
                                              child: Center(
                                                child: Text(
                                                  'Registered',
                                                  style:
                                                      AppTextStyles.whitelabel,
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Center(child: Text('No data available.'));
                  }
                }
              })),
    ));
  }
}
