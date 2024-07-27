import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../../Constants/styles.dart';
import '../../../Utils/Widgets/shimmer.dart';
import '../../Controllers/history_provider.dart';
import '../../Controllers/local_data.dart';
import 'history_summary.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppSpaces.verticalSpace40,
          Consumer<LocalDataProvider>(
            builder: (context, localData, child) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8),
                child: FutureBuilder(
                    future: Provider.of<HistoryProvider>(context, listen: false)
                        .historyData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            Skeleton(height: 40),
                            AppSpaces.verticalSpace20,
                            AppSpaces.verticalSpace10,
                            Skeleton(height: 50),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 50),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 50),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 50),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 50),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 50),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 50),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 50),
                            AppSpaces.verticalSpace15,
                            Skeleton(height: 50),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        var historyPage = snapshot.data;
                        if (historyPage != null &&
                            historyPage is Map<String, dynamic>) {
                          var myHistory = historyPage['data'];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:
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
                                    AppSpaces.horizontalSpace10,
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      child: FittedBox(
                                        child:  Text('My History',
                                            style: AppTextStyles.header2),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height - 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: myHistory.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(HistorySummary(
                                          historyEventId: myHistory[index]
                                              ['event_id'],
                                        ));
                                      },
                                      child: Card(
                                        elevation: 5,
                                        margin: EdgeInsets.only(
                                            left: 8, right: 8, bottom: 10),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          decoration: BoxDecoration(
                                            color: AppColor.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                          child:
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context).size.width * 0.7,
                                            child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child:  Text(
                                                myHistory[index]['event_title']
                                                    .toString(),
                                                style: AppTextStyles.label3,
                                              ),
                                            ),
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
