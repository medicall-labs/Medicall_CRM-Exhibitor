import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../../Constants/styles.dart';
import '../../../Utils/Widgets/shimmer.dart';
import '../../Controllers/history_provider.dart';
import '../../Controllers/local_data.dart';

class HistorySummary extends StatelessWidget {
  final int historyEventId;
  HistorySummary({super.key, required this.historyEventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<LocalDataProvider>(
          builder: (context, localData, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: FutureBuilder(
              future: Provider.of<HistoryProvider>(context, listen: false)
                  .previousAppointments(historyEventId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        AppSpaces.verticalSpace40,
                        Skeleton(height: 40),
                        AppSpaces.verticalSpace10,
                        Skeleton(height: 40),
                        AppSpaces.verticalSpace40,
                        Skeleton(height: 70),
                        AppSpaces.verticalSpace15,
                        Skeleton(height: 70),
                        AppSpaces.verticalSpace15,
                        Skeleton(height: 70),
                        AppSpaces.verticalSpace15,
                        Skeleton(height: 70),
                        AppSpaces.verticalSpace15,
                        Skeleton(height: 70),
                        AppSpaces.verticalSpace15,
                        Skeleton(height: 70),
                        AppSpaces.verticalSpace15,
                        Skeleton(height: 70),
                        AppSpaces.verticalSpace15,
                        Skeleton(height: 70),
                        AppSpaces.verticalSpace15,
                        Skeleton(height: 70),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  var historySummary = snapshot.data;
                  if (historySummary != null &&
                      historySummary is Map<String, dynamic>) {
                    var completedHistory = historySummary['data'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpaces.verticalSpace40,
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    width: 3,
                                    color: AppColor.black,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: AppColor.secondary,
                                  ),
                                ),
                              ),
                            ),
                            AppSpaces.horizontalSpace5,
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text('Completed Appointments',
                                  style: AppTextStyles.header2),
                            ),
                          ],
                        ),
                        AppSpaces.verticalSpace10,
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: FittedBox(
                              child: Text(
                                completedHistory[0]['event_title'],
                                style: AppTextStyles.header3,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 150,
                          child: ListView.builder(
                            itemCount: completedHistory.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      iconColor: AppColor.grey,
                                      textColor: AppColor.secondary,
                                      title: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.grey[200],
                                            child: completedHistory[index]
                                                        ['visitor_logo'] !=
                                                    ''
                                                ? ClipOval(
                                                    child: Image.network(
                                                        completedHistory[index]
                                                            ['visitor_logo'],
                                                        width: 30,
                                                        height: 30,
                                                        fit: BoxFit.cover),
                                                  )
                                                : Icon(
                                                    Icons.person_2_rounded,
                                                    color: Colors.grey[800],
                                                  ),
                                          ),
                                          AppSpaces.horizontalSpace10,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 25,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    completedHistory[index]
                                                        ['visitor_name'],
                                                    style: AppTextStyles.label,
                                                  ),
                                                ),
                                              ),
                                              AppSpaces.verticalSpace5,
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.55,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      AppSpaces
                                                          .horizontalSpace10,
                                                      Icon(
                                                        Icons.calendar_month,
                                                        size: 20,
                                                      ),
                                                      AppSpaces
                                                          .horizontalSpace10,
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: FittedBox(
                                                          child: Text(
                                                              completedHistory[
                                                                      index][
                                                                  'scheduled_on']),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      childrenPadding:
                                          const EdgeInsets.only(left: 15),
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: 'Working as ',
                                                    style:
                                                        AppTextStyles.label5),
                                                TextSpan(
                                                  text: completedHistory[index]
                                                      ['visitor_designation'],
                                                  style:
                                                      AppTextStyles.textBody2,
                                                ),
                                                TextSpan(
                                                    text: ' in ',
                                                    style:
                                                        AppTextStyles.label5),
                                                TextSpan(
                                                  text:
                                                      '${completedHistory[index]['visitor_organization']}, ${completedHistory[index]['visitor_city']}',
                                                  style:
                                                      AppTextStyles.textBody2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        AppSpaces.verticalSpace5,
                                        if (completedHistory[index]['notes'] !=
                                            "")
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          'Purpose of Meeting : ',
                                                      style:
                                                          AppTextStyles.label5),
                                                  TextSpan(
                                                    text:
                                                        completedHistory[index]
                                                            ['notes'],
                                                    style:
                                                        AppTextStyles.textBody2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        AppSpaces.verticalSpace5,
                                        if (completedHistory[index][
                                                'exhibitor_feedback_message'] !=
                                            "")
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          'Post Meeting Notes : ',
                                                      style:
                                                          AppTextStyles.label5),
                                                  TextSpan(
                                                    text: completedHistory[
                                                            index][
                                                        'exhibitor_feedback_message'],
                                                    style:
                                                        AppTextStyles.textBody2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(child: Text('No data available.')));
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
