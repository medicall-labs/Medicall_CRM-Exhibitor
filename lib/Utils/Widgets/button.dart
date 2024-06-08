import 'package:flutter/material.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';

import '../../Constants/styles.dart';

Widget customButton(
    {VoidCallback? tap,
      bool? status = false,
      String? text = '',
      Color? backgroundColor,
      Color? borderColor,
      BuildContext? context}) {
  return GestureDetector(
    onTap: status == true ? null : tap,
    child: Card(
      elevation: 5,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: status == false ? backgroundColor : Colors.grey,
            borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:AppColor.secondary,
          ),
        ),
        width: MediaQuery.of(context!).size.width,
        child: Text(
          status == false ? text! : 'Please wait...',
            style: AppTextStyles.textButton1,
        ),
      ),
    ),
  );
}