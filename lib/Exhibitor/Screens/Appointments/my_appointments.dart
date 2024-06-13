import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:provider/provider.dart';
import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../../Utils/Widgets/alertBox.dart';
import '../../../Utils/Widgets/select_time.dart';
import '../../../Utils/Widgets/shimmer.dart';
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
                  .appointmentData(localData.eventId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSpaces.verticalSpace40,
                        Skeleton(height: 40),
                        AppSpaces.verticalSpace10,
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
                      ],
                    ),
                  );
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
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.grey[200],
                                            child: appointments[index]
                                                        ['visitor_logo'] !=
                                                    ''
                                                ? ClipOval(
                                                    child: Image.network(
                                                        appointments[index]
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
                                                    // Text('Status ',
                                                    //     style: AppTextStyles
                                                    //         .label5),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: appointments[
                                                                        index]
                                                                    [
                                                                    'status'] ==
                                                                'Scheduled'
                                                            ? Colors.blue
                                                            : appointments[index][
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
                                              if (appointments[index]
                                                          ['status'] ==
                                                      'Scheduled' ||
                                                  appointments[index]
                                                          ['status'] ==
                                                      'Rescheduled' ||
                                                  appointments[index]
                                                          ['status'] ==
                                                      'Completed')
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        child: IconButton(
                                                            onPressed: () {
                                                              _showCommentDialog(
                                                                context,
                                                                appointments[
                                                                        index][
                                                                    'event_id'],
                                                                appointments[
                                                                        index][
                                                                    'appointment_id'],
                                                              );
                                                            },
                                                            tooltip:
                                                                'Completed',
                                                            icon: Icon(
                                                                appointments[index]
                                                                            [
                                                                            'status'] ==
                                                                        'Completed'
                                                                    ? Icons
                                                                        .message_outlined
                                                                    : Icons
                                                                        .add_task_rounded,
                                                                size: 20,
                                                                color: Colors
                                                                    .green)),
                                                      ),
                                                      if (appointments[index]
                                                              ['status'] !=
                                                          'Completed')
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 40,
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                    var dates = await Provider.of<AppointmentProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .eventDates(
                                                                            localData.eventId);
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              NumberPage(
                                                                                eventId: appointments[
                                                                                index][
                                                                                'event_id'],
                                                                                appointmentId: appointments[
                                                                                index][
                                                                                'appointment_id'],
                                                                                eventDates: dates['data']['event_dates'],
                                                                              )),
                                                                    );
                                                                  },
                                                                  tooltip:
                                                                      'Reschedule',
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .calendar_month,
                                                                      size:
                                                                          20)),
                                                            ),
                                                            Container(
                                                                width: 40,
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialogBox(
                                                                      context,
                                                                      'Confirm Action',
                                                                      'Are you sure you want to cancel this appointment?',
                                                                      appointments[
                                                                              index]
                                                                          [
                                                                          'event_id'],
                                                                      appointments[
                                                                              index]
                                                                          [
                                                                          'appointment_id'],
                                                                      'cancelled',
                                                                    );
                                                                  },
                                                                  tooltip:
                                                                      'Cancel',
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .cancel_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .red),
                                                                )),
                                                            Container(
                                                                width: 40,
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialogBox(
                                                                        context,
                                                                        'Confirm Action',
                                                                        'Are you sure this appointment is a No Show?',
                                                                        appointments[index]
                                                                            [
                                                                            'event_id'],
                                                                        appointments[index]
                                                                            [
                                                                            'appointment_id'],
                                                                        'no-show');
                                                                  },
                                                                  tooltip:
                                                                      'No Show',
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .person_off_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .red),
                                                                )),
                                                          ],
                                                        ),
                                                    ],
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
                                                  text: appointments[index]
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
                                                    style:
                                                        AppTextStyles.textBody2,
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

Future<void> _showCommentDialog(
    BuildContext context, eventID, appointmentID) async {
  String comment = '';

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300,
          ),
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text('Enter your feedback'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Comments'),
                      onChanged: (value) {
                        comment = value;
                      },
                      maxLines: 2,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<AppointmentProvider>(context, listen: false)
                        .actionStatus(
                            eventID, appointmentID, 'completed', comment);
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
