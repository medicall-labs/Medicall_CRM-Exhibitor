import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:provider/provider.dart';

import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../Controllers/appointment_provider.dart';

class AppointmentStatus {
  Widget buildContent(
    BuildContext context,
    String status,
    int id,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: FutureBuilder(
        future: Provider.of<AppointmentProvider>(context, listen: false)
            .appointmentData(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var appoints = snapshot.data;

            if (appoints != null && appoints is Map<String, dynamic>) {
              var data = appoints['data'] as List<dynamic>;
              return Column(
                children: [
                  Text(
                      status.substring(0, 1).toUpperCase() +
                          status.substring(1).toLowerCase(),
                      style: AppTextStyles.label4),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var index = 0; index < data.length; index++)
                            if (data[index]['status'] == status)
                              Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.grey[200],
                                              child: data[index]
                                                          ['visitor_logo'] !=
                                                      ''
                                                  ? ClipOval(
                                                      child: Image.network(
                                                          data[index]
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
                                            Container(
                                              height: 25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '${data[index]['visitor_name'].toString()}',
                                                    style: AppTextStyles.label,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        AppSpaces.verticalSpace5,
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'Working as ',
                                                  style: AppTextStyles.label5),
                                              TextSpan(
                                                text: data[index]
                                                    ['visitor_designation'],
                                                style: AppTextStyles.textBody2,
                                              ),
                                              TextSpan(
                                                  text: ' in ',
                                                  style: AppTextStyles.label5),
                                              TextSpan(
                                                text:
                                                    '${data[index]['visitor_organization']}, ${data[index]['visitor_city']}',
                                                style: AppTextStyles.textBody2,
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
                                              0.75,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                AppSpaces.horizontalSpace10,
                                                Icon(
                                                  Icons.calendar_month,
                                                  size: 20,
                                                ),
                                                AppSpaces.horizontalSpace10,
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: FittedBox(
                                                    child: Text(
                                                      data[index]
                                                          ['scheduled_on'],
                                                      style: GoogleFonts.lato(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color:
                                                              AppColor.primary),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        AppSpaces.verticalSpace5,
                                        if (data[index]['notes'] != "")
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
                                                    text: data[index]['notes'],
                                                    style:
                                                        AppTextStyles.textBody2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        AppSpaces.verticalSpace5,
                                        if (data[index][
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
                                                    text: data[index][
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
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: const Text('No data available.'));
            }
          }
        },
      ),
    );
  }
}
