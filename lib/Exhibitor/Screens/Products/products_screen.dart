import 'package:flutter/material.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/Products/products.dart';

import '../../../Constants/spacing.dart';
import '../../../Constants/styles.dart';
import '../../../Utils/Widgets/primary_tab_buttons.dart';
import 'event_products.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final _settingsButtonTrigger = ValueNotifier(0);
    return Scaffold(
      backgroundColor: AppColor.white,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: SafeArea(
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                        ],
                      ),
                      Text("Manage Product Details",
                          style: AppTextStyles.header2),
                    ],
                  ),
                  AppSpaces.verticalSpace10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PrimaryTabButton(
                          buttonText: "Add products",
                          itemIndex: 0,
                          notifier: _settingsButtonTrigger),
                      PrimaryTabButton(
                          buttonText: "Update Images",
                          itemIndex: 1,
                          notifier: _settingsButtonTrigger),
                    ],
                  ),
                  AppSpaces.verticalSpace20,
                  ValueListenableBuilder(
                      valueListenable: _settingsButtonTrigger,
                      builder: (BuildContext context, _, __) {
                        return _settingsButtonTrigger.value == 0
                            ? EventsProduct()
                            : Placeholder();
                      })
                ]),
              )),
        ));
  }
}
