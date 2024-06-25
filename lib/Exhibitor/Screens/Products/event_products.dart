import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import '../../../Constants/app_color.dart';
import '../../../Constants/spacing.dart';
import '../../../Constants/styles.dart';
import '../../Controllers/local_data.dart';
import '../../Controllers/products_provider.dart';
import 'add_products.dart';

class EventsProduct extends StatefulWidget {
  const EventsProduct({super.key});

  @override
  State<EventsProduct> createState() => _EventsProductState();
}

class _EventsProductState extends State<EventsProduct> {
  var profileDetails = GetStorage().read("profileData") != ''
      ? GetStorage().read("profileData")
      : '';

  var tokenDetails = GetStorage().read("local_store") != ''
      ? GetStorage().read("local_store")
      : '';

  List productId = [];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < profileDetails['data']['events'].length; i++)
      if (profileDetails['data']['events'][i]['id'] >=
          tokenDetails['current_event_id']) {
        for (var items in profileDetails['data']['events'][i]['products'])
          productId.add(items['id']);
      }
    return Consumer<LocalDataProvider>(
        builder: (context, localData, child) => Container(
                child: Column(
                  children: [
                    for (int i = 0;
                        i < profileDetails['data']['events'].length;
                        i++)
                      if (profileDetails['data']['events'][i]['id'] >=
                          localData.eventId)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.event,
                                    size: 15,
                                    color: AppColor.grey,
                                  ),
                                  AppSpaces.horizontalSpace5,
                                  Container(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width *
                                        0.7,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        profileDetails['data']['events'][i]
                                                ['name'] ??
                                            'N/A',
                                        style: AppTextStyles.label7,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return ProductSearchBottomSheet(
                                              eventName:
                                                  profileDetails['data']
                                                      ['events'][i]['name'],
                                              eventId: profileDetails['data']
                                                  ['events'][i]['id'],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        size: 20,
                                      ))
                                ],
                              ),
                              if (profileDetails['data']['events'][i]
                                      ['products'] !=
                                  null)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var eventProduct
                                          in profileDetails['data']['events']
                                                  [i]['products'] ??
                                              [])
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_right,
                                              size: 10,
                                              color: AppColor.grey,
                                            ),
                                            AppSpaces.horizontalSpace5,
                                            Container(
                                              width: 150,
                                              child: Text(
                                                eventProduct['name'] ??
                                                    'N/A',
                                                style:
                                                    AppTextStyles.textBody,
                                              ),
                                            ),
                                            AppSpaces.horizontalSpace10,
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                      context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Confirm Delete'),
                                                      content: Text(
                                                          'Are you sure you want to delete ${eventProduct['name']}?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Text(
                                                              'Cancel'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text(
                                                              'Delete'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                            setState(() {
                                                              if (productId
                                                                  .contains(
                                                                      eventProduct[
                                                                          'id'])) {
                                                                productId.remove(
                                                                    eventProduct[
                                                                        'id']);
                                                                ProductsProvider()
                                                                    .addProductstoCurrentEvent(
                                                                  localData
                                                                      .eventId,
                                                                  productId,
                                                                );
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                size: 20,
                                                color: AppColor.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              Divider(),
                            ],
                          ),
                        ),
                  ],
                )
        ),
    );
  }
}
