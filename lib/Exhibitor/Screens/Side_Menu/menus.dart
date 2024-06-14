import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../../Constants/styles.dart';
import '../../../Utils/Widgets/shimmer.dart';
import '../My_History/history.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          title: Text(
            'Profile',
            style: AppTextStyles.header2,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<ProfileProvider>(
                builder: (context, localData, child) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: FutureBuilder(
                        future:
                            Provider.of<ProfileProvider>(context, listen: false)
                                .profileData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Skeleton(height: 80),
                                  AppSpaces.verticalSpace5,
                                  Skeleton(height: 300),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            var profilePage = snapshot.data;
                            if (profilePage != null &&
                                profilePage is Map<String, dynamic>) {
                              var profile = profilePage['data'];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: AppColor.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey[200],
                                          child: profile['logo'] != ''
                                              ? ClipOval(
                                                  child: Image.network(
                                                      profile['logo'],
                                                      fit: BoxFit.cover),
                                                )
                                              : Icon(
                                                  Icons.person_2_rounded,
                                                  color: Colors.grey[800],
                                                ),
                                        ),
                                        AppSpaces.horizontalSpace10,
                                        Column(
                                          children: [
                                            Text(
                                              profile['name'].toString(),
                                              style: AppTextStyles.label6,
                                            ),
                                            Text(
                                              profile['mobile_number']
                                                  .toString(),
                                              style: AppTextStyles.label5,
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        TextButton(
                                            onPressed: () {},
                                            child: Text('Edit'))
                                      ],
                                    ),
                                  ),
                                  AppSpaces.verticalSpace5,
                                  Container(
                                    color: AppColor.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  child: Icon(
                                                    Icons.person,
                                                    color: AppColor.primary
                                                        .withOpacity(0.8),
                                                  ),
                                                ),
                                                AppSpaces.horizontalSpace20,
                                                Text(
                                                  'My Profile',
                                                  style: AppTextStyles.label,
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_forward_ios_rounded,
                                                  color: Colors.grey,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        AppSpaces.verticalSpace20,
                                        GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                child: Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: AppColor.primary
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              AppSpaces.horizontalSpace20,
                                              Text(
                                                'Products',
                                                style: AppTextStyles.label,
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Colors.grey,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                        AppSpaces.verticalSpace20,
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(MyHistory());
                                          },
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                child: Icon(
                                                  Icons.history_rounded,
                                                  color: AppColor.primary
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                              AppSpaces.horizontalSpace20,
                                              Text(
                                                'History',
                                                style: AppTextStyles.label,
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Colors.grey,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return const Center(
                                  child: Text('No data available.'));
                            }
                          }
                        })),
              )
            ],
          ),
        ));
  }
}
