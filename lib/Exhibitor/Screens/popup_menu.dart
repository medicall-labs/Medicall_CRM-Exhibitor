import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Constants/app_color.dart';
import '../../Constants/spacing.dart';
import '../../Constants/styles.dart';
import '../Controllers/auth_provider.dart';
import 'My_History/history.dart';
import 'My_Profile/profile.dart';
import 'Products/products.dart';

class CustomPopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: ColorFiltered(
        colorFilter: ColorFilter.mode(
          AppColor.secondary,
          BlendMode.modulate,
        ),
        child: Container(
          height: 30,
          child: Lottie.asset('assets/lottie/menu.json'),
        ),
      ),
      color: Colors.white,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.person,
                  color: AppColor.black.withOpacity(0.5),
                  size: 20,
                ),
              ),
              AppSpaces.horizontalSpace20,
              Text(
                'My Profile',
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColor.black.withOpacity(0.5),
                  size: 20,
                ),
              ),
              AppSpaces.horizontalSpace20,
              Text(
                'Products',
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.history_rounded,
                  color: AppColor.black.withOpacity(0.5),
                  size: 20,
                ),
              ),
              AppSpaces.horizontalSpace20,
              Text(
                'My History',
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.change_circle_outlined,
                  color: AppColor.black.withOpacity(0.5),
                  size: 20,
                ),
              ),
              AppSpaces.horizontalSpace20,
              Text(
                'Change Password',
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 5,
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.logout,
                  color: AppColor.black.withOpacity(0.5),
                  size: 20,
                ),
              ),
              AppSpaces.horizontalSpace20,
              Text(
                'Logout',
                style: AppTextStyles.label,
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          Get.to(() => MyProfile());
        } else if (value == 2) {
          Get.to(() => AllProducts());
        } else if (value == 3) {
          Get.to(() => MyHistory());
        } else if (value == 4) {
        } else if (value == 5) {
          AuthenticationProvider().logout();
        }
      },
    );
  }
}
