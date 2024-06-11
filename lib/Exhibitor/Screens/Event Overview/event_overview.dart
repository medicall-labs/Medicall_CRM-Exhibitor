import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:medicall_exhibitor/Constants/spacing.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/event_provider.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/Event%20Overview/stall_image.dart';
import 'package:medicall_exhibitor/Utils/Widgets/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../Controllers/local_data.dart';

class EventOverview extends StatefulWidget {
  @override
  _EventOverviewState createState() => _EventOverviewState();
}

class _EventOverviewState extends State<EventOverview> {
  var UserDetails = GetStorage().read("local_store") != ''
      ? GetStorage().read("local_store")
      : '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppSpaces.verticalSpace40,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
          Consumer<LocalDataProvider>(
            builder: (context, localData, child) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: FutureBuilder(
                    future: Provider.of<EventProvider>(context, listen: false)
                        .eventData(localData.eventId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
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
                              AppSpaces.verticalSpace10,
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  insights['current_event_title'],
                                  style: AppTextStyles.header3,
                                ),
                              ),
                              AppSpaces.verticalSpace10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Card(
                                    elevation: 5,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      decoration: BoxDecoration(
                                          color: AppColor.bgColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Scheduled',
                                            style: AppTextStyles.label2,
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Text(
                                            insights['scheduled_count']
                                                .toString(),
                                            style: AppTextStyles.label4,
                                          ),
                                          Divider(height: 20),
                                          Text(
                                            'Completed',
                                            style: AppTextStyles.label2,
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Text(
                                            insights['completed_count']
                                                .toString(),
                                            style: AppTextStyles.label4,
                                          ),
                                          Divider(height: 20),
                                          Text(
                                            'Rescheduled',
                                            style: AppTextStyles.label2,
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Text(
                                            insights['rescheduled_count']
                                                .toString(),
                                            style: AppTextStyles.label4,
                                          ),
                                          Divider(height: 20),
                                          Text(
                                            'No Show',
                                            style: AppTextStyles.label2,
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Text(
                                            insights['lapsed_count'].toString(),
                                            style: AppTextStyles.label4,
                                          ),
                                          Divider(height: 20),
                                          Text(
                                            'Cancelled',
                                            style: AppTextStyles.label2,
                                          ),
                                          AppSpaces.verticalSpace5,
                                          Text(
                                            insights['cancelled_count']
                                                .toString(),
                                            style: AppTextStyles.label4,
                                          ),
                                          Divider(height: 20),
                                          Text(
                                            'Total Appointments',
                                            style: AppTextStyles.label2,
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
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        width: 75,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  color: Colors.purple[300],
                                                ),
                                                AppSpaces.horizontalSpace5,
                                                Text(
                                                  'Scheduled',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  color: Colors.green[300],
                                                ),
                                                AppSpaces.horizontalSpace5,
                                                Text(
                                                  'Completed',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  color: Colors.orange[300],
                                                ),
                                                AppSpaces.horizontalSpace5,
                                                Text(
                                                  'Rescheduled',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  color: Colors.yellow[300],
                                                ),
                                                AppSpaces.horizontalSpace5,
                                                Text(
                                                  'No Show',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 10,
                                                  width: 10,
                                                  color: Colors.pink[300],
                                                ),
                                                AppSpaces.horizontalSpace5,
                                                Text(
                                                  'Cancelled',
                                                  style:
                                                      AppTextStyles.textBody3,
                                                )
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
                                    title: Text('Hall Layout',
                                        style: AppTextStyles.textBody),
                                    onTap: () {
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
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle),
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
                                                          color: AppColor
                                                              .secondary),
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
                                            "Goal Completed",
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
