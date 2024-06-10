import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:medicall_exhibitor/Constants/spacing.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';

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
        backgroundColor: AppColor.bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppSpaces.verticalSpace40,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hello, \n${UserDetails['data']['name'].toString()}',
                        style: AppTextStyles.header2,
                      ),
                      // Lottie.asset(
                      //     'assets/lottie/profile.json',
                      //     fit: BoxFit.cover,
                      //   ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 4,
                      shrinkWrap: true,
                      primary: false,
                      childAspectRatio: 1 / 1.2,
                      children: <Widget>[]),
                ),
              ],
            ),
          ),
        ));
  }
}
