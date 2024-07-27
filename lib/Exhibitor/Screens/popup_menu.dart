import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../Constants/app_color.dart';
import '../../Constants/spacing.dart';
import '../../Constants/styles.dart';
import '../../Utils/Forms/form_input_with _label.dart';
import '../Controllers/auth_provider.dart';
import 'My_History/history.dart';
import 'My_Profile/profile.dart';
import 'Products/products.dart';
import 'Products/products_screen.dart';

class CustomPopupMenu extends StatelessWidget {
  final TextEditingController _oldPasscode = TextEditingController();
  final TextEditingController _newPasscode = TextEditingController();
  final TextEditingController _confirmNewPasscode = TextEditingController();
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
          Get.to(() => ProductScreen());
        } else if (value == 3) {
          Get.to(() => MyHistory());
        } else if (value == 4) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.60,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelledFormInput(
                      keyboardType: "Password",
                      controller: _oldPasscode,
                      obscureText: false,
                      label: "Current Password"),
                  LabelledFormInput(
                      keyboardType: "Password",
                      controller: _newPasscode,
                      obscureText: true,
                      label: "New Password"),
                  LabelledFormInput(
                      keyboardType: "Password",
                      controller: _confirmNewPasscode,
                      obscureText: true,
                      label: "Confirm Password"),
                  AppSpaces.verticalSpace20,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_newPasscode.text == _confirmNewPasscode.text) {
                            AuthenticationProvider().changePassword(
                                _oldPasscode.text,
                                _newPasscode.text,
                                _confirmNewPasscode.text);
                          } else {
                            Get.snackbar(
                              'Error',
                              'New password and Confirm password do not match',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(AppColor.secondary),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: AppColor.secondary)))),
                        child: Text('Submit Changes',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white))),
                  ),
                ],
              ),
            ),
          );
        } else if (value == 5) {
          AuthenticationProvider().logout();
        }
      },
    );
  }
}
