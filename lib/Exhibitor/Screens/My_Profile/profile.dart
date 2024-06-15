import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/profile_provider.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/My_Profile/edit_profile.dart';
import 'package:provider/provider.dart';

import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../../Constants/styles.dart';
import '../../../Utils/Widgets/shimmer.dart';
import '../../Controllers/local_data.dart';
import '../../Models/profile_model.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppSpaces.verticalSpace40,
              Consumer<LocalDataProvider>(
                builder: (context, localData, child) => FutureBuilder(
                    future: Provider.of<ProfileProvider>(context, listen: false)
                        .profileData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            Skeleton(height: 40),
                            AppSpaces.verticalSpace20,
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        var profilePage = snapshot.data;
                        if (profilePage != null &&
                            profilePage is Map<String, dynamic>) {
                          var profile = ProfileModel.fromJson(profilePage);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                width: double.infinity,
                                color: AppColor.white,
                                child: Center(
                                  child: Text('My Profile',
                                      style: AppTextStyles.header3),
                                ),
                              ),
                              AppSpaces.verticalSpace5,
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              if (profile.data?.logo != null)
                                                Center(
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage:
                                                        NetworkImage(profile
                                                            .data!.logo!),
                                                  ),
                                                ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      profile.data?.name ??
                                                          'N/A',
                                                      style: AppTextStyles
                                                          .profileHead,
                                                    ),
                                                    Text(
                                                      profile.data?.email ??
                                                          'N/A',
                                                      style: AppTextStyles
                                                          .profileHead2,
                                                    ),
                                                    Text(
                                                      profile.data
                                                              ?.mobileNumber ??
                                                          'N/A',
                                                      style: AppTextStyles
                                                          .profileHead2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    Get.to(EditProfile());
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 20,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppSpaces.verticalSpace5,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contact Person Details',
                                            style: AppTextStyles.label6,
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 15,
                                                color: AppColor.grey,
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Text(
                                                'Name',
                                                style: AppTextStyles.label7,
                                              ),
                                              Spacer(),
                                              Text(
                                                '${profile.data?.salutation ?? ' '} ${profile.data?.contactPerson ?? "N/A"}',
                                                style: AppTextStyles.label,
                                              )
                                            ],
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                size: 15,
                                                color: AppColor.grey,
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Text(
                                                'Contact Number',
                                                style: AppTextStyles.label7,
                                              ),
                                              Spacer(),
                                              Text(
                                                profile.data?.contactNumber ??
                                                    'N/A',
                                                style: AppTextStyles.label,
                                              )
                                            ],
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.work,
                                                size: 15,
                                                color: AppColor.grey,
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Text(
                                                'Designation',
                                                style: AppTextStyles.label7,
                                              ),
                                              Spacer(),
                                              Text(
                                                profile.data?.designation ??
                                                    'N/A',
                                                style: AppTextStyles.label,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppSpaces.verticalSpace5,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Information',
                                            style: AppTextStyles.label6,
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.person_2_outlined,
                                                size: 15,
                                                color: AppColor.grey,
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Text(
                                                'Profile Name',
                                                style: AppTextStyles.label7,
                                              ),
                                              Spacer(),
                                              Text(
                                                profile.data?.username ??
                                                    "N/A",
                                                style: AppTextStyles.label,
                                              )
                                            ],
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.business,
                                                size: 15,
                                                color: AppColor.grey,
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Text(
                                                'Category Name',
                                                style: AppTextStyles.label7,
                                              ),
                                              Spacer(),
                                              Text(
                                                profile.data?.categoryName ??
                                                    "N/A",
                                                style: AppTextStyles.label,
                                              )
                                            ],
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.language,
                                                size: 15,
                                                color: AppColor.grey,
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Text(
                                                'Website',
                                                style: AppTextStyles.label7,
                                              ),
                                              Spacer(),
                                              Text(
                                                profile.data?.websiteUrl ??
                                                    "N/A",
                                                style: AppTextStyles.label,
                                              )
                                            ],
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.description,
                                                size: 15,
                                                color: AppColor.grey,
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Text(
                                                'Description',
                                                style: AppTextStyles.label7,
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 200,
                                                color: Colors
                                                    .grey.shade50,
                                                child: Text(
                                                  profile.data?.description ??
                                                      'N/A',
                                                  style: AppTextStyles.label,
                                                ),
                                              )
                                            ],
                                          ),
                                          AppSpaces.verticalSpace10,
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.home_work_outlined,
                                                size: 15,
                                                color: AppColor.grey,
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Text(
                                                'Address',
                                                style: AppTextStyles.label7,
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 200,
                                                color: Colors
                                                    .grey.shade50,
                                                child: Text(
                                                  profile.data?.address ??
                                                      'N/A',
                                                  style: AppTextStyles.label,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppSpaces.verticalSpace5,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Events & Products',
                                            style: AppTextStyles.label6,
                                          ),
                                          AppSpaces.verticalSpace5,
                                          for (var event
                                              in profile.data?.events ?? [])
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.event,
                                                      size: 15,
                                                      color: AppColor.grey,
                                                    ),
                                                    AppSpaces.horizontalSpace5,
                                                    Text(
                                                      event.name ?? 'N/A',
                                                      style:
                                                          AppTextStyles.label7,
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      event.stallNo ?? 'N/A',
                                                      style:
                                                          AppTextStyles.label,
                                                    ),
                                                  ],
                                                ),
                                                // Display event products if available
                                                if (event.eventProducts != null)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20, top: 5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        for (var eventProduct
                                                            in event.eventProducts ??
                                                                [])
                                                          Container(
                                                            color: Colors
                                                                .grey.shade50,
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .arrow_right,
                                                                  size: 10,
                                                                  color:
                                                                      AppColor
                                                                          .grey,
                                                                ),
                                                                AppSpaces
                                                                    .horizontalSpace5,
                                                                Text(
                                                                  eventProduct
                                                                          .name ??
                                                                      'N/A',
                                                                  style: AppTextStyles
                                                                      .textBody,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                Divider(),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                              child: Text('No data available.'));
                        }
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
