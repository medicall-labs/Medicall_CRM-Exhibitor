// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../Constants/spacing.dart';
// import '../../../Constants/styles.dart';
// import '../../Controllers/local_data.dart';
//
// class MyHistory extends StatefulWidget {
//   const MyHistory({super.key});
//
//   @override
//   State<MyHistory> createState() => _MyHistoryState();
// }
//
// class _MyHistoryState extends State<MyHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               AppSpaces.verticalSpace40,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [],
//                 ),
//               ),
//               Consumer<LocalDataProvider>(
//                 builder: (context, localData, child) => Padding(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//                     child: FutureBuilder(
//                         future: Provider.of<AppointmentProvider>(context, listen: false)
//                             .eventData(localData.eventId),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState == ConnectionState.waiting) {
//                             return CircularProgressIndicator();
//                           } else if (snapshot.hasError) {
//                             return Center(child: Text('Error: ${snapshot.error}'));
//                           } else {
//                             var appointmentsPage = snapshot.data;
//                             if (appointmentsPage != null &&
//                                 appointmentsPage is Map<String, dynamic>) {
//                               var appointments = appointmentsPage['data'];
//
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   AppSpaces.verticalSpace10,
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       appointments.toString(),
//                                       style: AppTextStyles.header3,
//                                     ),
//                                   ),
//                                   AppSpaces.verticalSpace10,
//
//                                 ],
//                               );
//                             } else {
//                               return const Center(
//                                   child: Text('No data available.'));
//                             }
//                           }
//                         })),
//               )
//             ],
//           ),
//         ));
//   }
// }
