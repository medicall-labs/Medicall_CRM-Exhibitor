import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:medicall_exhibitor/Constants/spacing.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/event_provider.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/Event%20Overview/stall_image.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/My_History/history.dart';
import 'package:medicall_exhibitor/Utils/Widgets/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../../Utils/Identity/identity.dart';
import '../../../Utils/Widgets/shimmer.dart';
import '../../Controllers/auth_provider.dart';
import '../../Controllers/local_data.dart';
import '../My_Profile/profile.dart';
import '../Products/products.dart';
import 'bottom_sheet.dart';

class EventOverview extends StatefulWidget {
  @override
  _EventOverviewState createState() => _EventOverviewState();
}

class _EventOverviewState extends State<EventOverview> {
  final profileLogo = GetStorage().read("profileData") != ''
      ? GetStorage().read("profileData")
      : '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Consumer<LocalDataProvider>(
        builder: (context, localData, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: FutureBuilder(
                future: Provider.of<EventProvider>(context, listen: false)
                    .eventData(localData.eventId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skeleton(height: 40),
                          AppSpaces.verticalSpace10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Skeleton(
                                height: 370,
                                width: MediaQuery.of(context).size.width * 0.35,
                              ),
                              Skeleton(
                                height: MediaQuery.of(context).size.width * 0.5,
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                            ],
                          ),
                          AppSpaces.verticalSpace10,
                          Skeleton(height: 50),
                          AppSpaces.verticalSpace10,
                          Skeleton(height: 150),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    var eventInsightsPage = snapshot.data;
                    if (eventInsightsPage != null &&
                        eventInsightsPage is Map<String, dynamic>) {
                      var insights = eventInsightsPage['data'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (profileLogo != null)
                                CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.grey[200],
                                    child: profileLogo?['data']['logo'] != ''
                                        ? ClipOval(
                                            child: Image.network(
                                                profileLogo['data']['logo'],
                                                fit: BoxFit.cover),
                                          )
                                        : Container()),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: FittedBox(
                                  child: Text(
                                    insights['current_event_title'],
                                    style: AppTextStyles.header3,
                                  ),
                                ),
                              ),
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
                          CustomTextWidget(),
                          AppSpaces.verticalSpace10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                elevation: 5,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  decoration: BoxDecoration(
                                      color: AppColor.bgColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          if(insights['scheduled_count'] != 0)
                                          _showBottomSheet(context, 'Scheduled',
                                              localData.eventId);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                child: FittedBox(
                                                  child: Text(
                                                    'Scheduled',
                                                    style: AppTextStyles.label2,
                                                  ),
                                                ),
                                              ),
                                              AppSpaces.verticalSpace5,
                                              Text(
                                                insights['scheduled_count']
                                                    .toString(),
                                                style: AppTextStyles.label4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(height: 20),
                                      GestureDetector(

                                        onTap: () {
                                          if(insights['completed_count'] != 0)
                                          _showBottomSheet(context, 'Completed',
                                              localData.eventId);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                child: FittedBox(
                                                  child: Text(
                                                    'Completed',
                                                    style: AppTextStyles.label2,
                                                  ),
                                                ),
                                              ),
                                              AppSpaces.verticalSpace5,
                                              Text(
                                                insights['completed_count']
                                                    .toString(),
                                                style: AppTextStyles.label4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          if(insights['rescheduled_count'] != 0)
                                          _showBottomSheet(context,
                                              'Rescheduled', localData.eventId);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.165,
                                                child: FittedBox(
                                                  child: Text(
                                                    'Rescheduled',
                                                    style: AppTextStyles.label2,
                                                  ),
                                                ),
                                              ),
                                              AppSpaces.verticalSpace5,
                                              Text(
                                                insights['rescheduled_count']
                                                    .toString(),
                                                style: AppTextStyles.label4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          if(insights['lapsed_count'] != 0)
                                          _showBottomSheet(context, 'No-show',
                                              localData.eventId);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.11,
                                                child: FittedBox(
                                                  child: Text(
                                                    'No Show',
                                                    style: AppTextStyles.label2,
                                                  ),
                                                ),
                                              ),
                                              AppSpaces.verticalSpace5,
                                              Text(
                                                insights['lapsed_count']
                                                    .toString(),
                                                style: AppTextStyles.label4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          if(insights['cancelled_count'] != 0)
                                          _showBottomSheet(context, 'Cancelled',
                                              localData.eventId);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                child: FittedBox(
                                                  child: Text(
                                                    'Cancelled',
                                                    style: AppTextStyles.label2,
                                                  ),
                                                ),
                                              ),
                                              AppSpaces.verticalSpace5,
                                              Text(
                                                insights['cancelled_count']
                                                    .toString(),
                                                style: AppTextStyles.label4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(height: 20),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: FittedBox(
                                          child: Text(
                                            'Total Appointments',
                                            style: AppTextStyles.label2,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        insights['total_appointments_count']
                                            .toString(),
                                        style: AppTextStyles.label4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (insights['total_appointments_count'] != 0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Stack(children: [
                                        Center(
                                            child: PieChart(
                                          insights: insights,
                                        )),
                                        Center(
                                            child: Text(
                                          insights['total_appointments_count']
                                              .toString(),
                                          style: AppTextStyles.header3,
                                        ))
                                      ]),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 10,
                                                color: Color(0xff3abfaf),
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.125,
                                                child: FittedBox(
                                                    child: Text(
                                                  'Scheduled',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 10,
                                                color: Color(0xff8dbf3a),
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.125,
                                                child: FittedBox(
                                                    child: Text(
                                                  'Completed',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 10,
                                                color: Color(0xffbf3a4a),
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.14,
                                                child: FittedBox(
                                                    child: Text(
                                                  'Rescheduled',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 10,
                                                color: Color(0xff6c3abf),
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                child: FittedBox(
                                                    child: Text(
                                                  'No Show',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 10,
                                                width: 10,
                                                color: Color(0xff3abf6c),
                                              ),
                                              AppSpaces.horizontalSpace5,
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.115,
                                                child: FittedBox(
                                                    child: Text(
                                                  'Cancelled',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                          AppSpaces.verticalSpace10,
                          Card(
                            elevation: 5,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: ListTile(
                                title: Text(
                                    insights['stall_no'].isNotEmpty
                                        ? 'Stall no : ${insights['stall_no']}'
                                        : 'Hall Layout',
                                    style: AppTextStyles.textBody),
                                onTap: () {
                                  if (insights['hall_layout'] != "")
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PDFViewer(
                                            pdfPath: insights['hall_layout']),
                                      ),
                                    );
                                },
                              ),
                            ),
                          ),
                          AppSpaces.verticalSpace10,
                          if (insights['total_appointments_count'] != 0)
                            Card(
                              elevation: 5,
                              child: Container(
                                height: 150,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: AppColor.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 8,
                                                    color: Colors.black12)),
                                            child: Center(
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: Text(
                                                  "${((insights['completed_count'] / insights['total_appointments_count']) * 100).toInt()}%",
                                                  style: AppTextStyles.label,
                                                )),
                                              ),
                                            )),
                                        Positioned(
                                          top: 5,
                                          left: 5,
                                          child: RotatedBox(
                                            quarterTurns: 1,
                                            child:
                                                TweenAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 0.0,
                                                  end: insights[
                                                          'completed_count'] /
                                                      insights[
                                                          'total_appointments_count']),
                                              duration: const Duration(
                                                  milliseconds: 1000),
                                              builder: (context, value, _) =>
                                                  SizedBox(
                                                width: 90,
                                                height: 90,
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: 8,
                                                        value: value,
                                                        color:
                                                            AppColor.secondary),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Appointments",
                                          style: AppTextStyles.textBody,
                                        ),
                                        Text(
                                          "Goals Completed",
                                          style: AppTextStyles.textBody2,
                                        ),
                                        Text(
                                          "${insights['completed_count'].toString()} / ${insights['total_appointments_count'].toString()}",
                                          style: AppTextStyles.label3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    } else {
                      return const Center(child: Text('No data available.'));
                    }
                  }
                })),
      ),
    ));
  }
}

void _showBottomSheet(BuildContext context, data, id) {
  var appointmentStatus = AppointmentStatus();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      // Call the method to build the content
      return appointmentStatus.buildContent(context, data, id);
    },
  );
}
