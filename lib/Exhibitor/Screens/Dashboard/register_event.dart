// import 'package:flutter/material.dart';
//
// import 'package:get_storage/get_storage.dart';
// import 'package:medicall_exhibitor/Constants/spacing.dart';
// import 'package:medicall_exhibitor/Exhibitor/Controllers/dashboard_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../../Constants/app_color.dart';
// import '../../../Constants/styles.dart';
// import '../../../Utils/Widgets/register_event_card.dart';
// import '../../Controllers/local_data.dart';
//
//
//
// class EventRegistration extends StatelessWidget {
//   final UserDetails = GetStorage().read("local_store") != ''
//       ? GetStorage().read("local_store")
//       : '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColor.bgColor,
//         appBar: AppBar(
//           elevation: 0,
//           title: Text(
//             'Hello,\n${UserDetails['data']['name'].toString()}',
//             style: AppTextStyles.header2,
//           ),
//           backgroundColor: Colors.transparent,
//         ),
//         body: Consumer<LocalDataProvider>(
//           builder: (context, localData, child) => Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               child: FutureBuilder(
//                   future: Provider.of<DashboardProvider>(context, listen: false)
//                       .dashboardData(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else {
//                       var registerEventPage = snapshot.data;
//                       if (registerEventPage != null &&
//                           registerEventPage is Map<String, dynamic>) {
//                         var myDeviations = registerEventPage['data'];
//
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Current Event',
//                               style: AppTextStyles.header3,
//                             ),
//                             AppSpaces.verticalSpace5,
//                             EventCard(
//                               eventData: registerEventPage['data']
//                                   ['currentEvent'],
//                               cardHeight: 250,
//                               cardWidth: double.infinity,
//                               buttonHeight: 50,
//                             ),
//                             AppSpaces.verticalSpace40,
//                             Text(
//                               'Upcoming Events',
//                               style: AppTextStyles.header3,
//                             ),
//                             AppSpaces.verticalSpace5,
//                             Container(
//                               height: 200,
//                               child: Expanded(
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: registerEventPage['data']
//                                           ['upcomingEvents']
//                                       .length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return EventCard(
//                                       eventData: registerEventPage['data']
//                                           ['upcomingEvents'][index],
//                                       cardHeight: 150,
//                                       cardWidth: 200,
//                                       buttonHeight: 30,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             )
//                           ],
//                         );
//                       } else {
//                         return const Center(child: Text('No data available.'));
//                       }
//                     }
//                   })),
//         ));
//   }
// }
