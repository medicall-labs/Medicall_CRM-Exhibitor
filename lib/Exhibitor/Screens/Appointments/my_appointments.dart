import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:provider/provider.dart';
import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../Controllers/appointment_provider.dart';
import '../../Controllers/local_data.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<LocalDataProvider>(
          builder: (context, localData, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: FutureBuilder(
              future: Provider.of<AppointmentProvider>(context, listen: false)
                  .eventData(localData.eventId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  var appointmentsPage = snapshot.data;
                  if (appointmentsPage != null &&
                      appointmentsPage is Map<String, dynamic>) {
                    var appointments = appointmentsPage['data'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpaces.verticalSpace40,
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Appointments',
                              style: AppTextStyles.header2),
                        ),
                        AppSpaces.verticalSpace10,
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            appointments[0]['event_title'],
                            style: AppTextStyles.header3,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: ListView.builder(
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              List<String> parts = appointments[index]
                              ['scheduled_on']
                                  .split(',');
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
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: appointments[index]
                                            ['visitor_logo'] !=
                                                ''
                                                ? Image.network(
                                                appointments[index]
                                                ['visitor_logo'])
                                                : Icon(
                                                Icons.person_2_rounded),
                                          ),
                                          AppSpaces.horizontalSpace10,
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.5,
                                                child: Text(
                                                  appointments[index]
                                                  ['visitor_name'],
                                                  style: AppTextStyles.label,
                                                ),
                                              ),
                                              AppSpaces.verticalSpace5,
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.5,
                                                child: Row(
                                                  children: [
                                                    Text('Status ',
                                                        style: AppTextStyles
                                                            .label5),
                                                    Container(
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 5,
                                                          vertical: 2),
                                                      decoration:
                                                      BoxDecoration(
                                                        color: appointments[
                                                        index]
                                                        [
                                                        'status'] ==
                                                            'Scheduled'
                                                            ? Colors.blue
                                                            : appointments[index]
                                                        [
                                                        'status'] ==
                                                            'Rescheduled'
                                                            ? Colors
                                                            .grey[400]
                                                            : appointments[index]
                                                        [
                                                        'status'] ==
                                                            'Completed'
                                                            ? Colors
                                                            .green
                                                            : appointments[index]['status'] ==
                                                            'Confirmed'
                                                            ? Colors
                                                            .green
                                                            : appointments[index]['status'] ==
                                                            'No-show'
                                                            ? Colors.red
                                                            : appointments[index]['status'] == 'Cancelled'
                                                            ? Colors.red
                                                            : AppColor.bgColor,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                      ),
                                                      child: Text(
                                                        appointments[index]
                                                        ['status'],
                                                        style: AppTextStyles
                                                            .whitelabel,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              AppSpaces.verticalSpace5,
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.6,
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
                                                      Text(appointments[index]
                                                      ['scheduled_on']),
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
                                                  text: appointments[index][
                                                  'visitor_designation'],
                                                  style:
                                                  AppTextStyles.textBody2,
                                                ),
                                                TextSpan(
                                                    text: ' in ',
                                                    style:
                                                    AppTextStyles.label5),
                                                TextSpan(
                                                  text:
                                                  '${appointments[index]['visitor_organization']}, ${appointments[index]['visitor_city']}',
                                                  style:
                                                  AppTextStyles.textBody2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        AppSpaces.verticalSpace5,
                                        if (appointments[index]['notes'] != "")
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
                                                    text: appointments[index]
                                                    ['notes'],
                                                    style: AppTextStyles
                                                        .textBody2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        AppSpaces.verticalSpace5,
                                        if (appointments[index][
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
                                                    text: appointments[index][
                                                    'exhibitor_feedback_message'],
                                                    style: AppTextStyles
                                                        .textBody2,
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
                    return const Center(child: Text('No data available.'));
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
