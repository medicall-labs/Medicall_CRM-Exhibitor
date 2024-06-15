import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../Constants/spacing.dart';
import '../../Utils/Forms/form_input_with _label.dart';
import '../Exhibitor/Controllers/auth_provider.dart';
import '../Exhibitor/Services/remote_services.dart';
import 'package:get/get.dart';

import '../Utils/Identity/identity.dart';
import '../Utils/Widgets/button.dart';
import '../Utils/Widgets/snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool obscureText = false;

  bool isOtpRequested = false;
  bool validateMobileNumber = false;
  List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpaces.verticalSpace40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Login to Continue...',
                      style: AppTextStyles.header1,
                    ),
                    CustomTextWidget(),
                  ],
                ),
                SizedBox(
                  height: 150,
                  child: Center(
                    child: Image.asset(
                      "assets/images/Logo.png",
                      width: 150,
                    ),
                  ),
                ),
                LabelledFormInput(
                    keyboardType: "number",
                    controller: _userIdController,
                    obscureText: false,
                    label: "Mobile Number"),
                if (_userIdController.text.length != 10 && validateMobileNumber)
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'Please enter your mobile number and request OTP',
                      style: AppTextStyles.validation,
                    ),
                  ),
                AppSpaces.verticalSpace10,
                Visibility(
                  visible: !isOtpRequested,
                  child: LabelledFormInput(
                      keyboardType: "text",
                      controller: _passController,
                      obscureText: true,
                      label: "Password"),
                ),
                Visibility(
                    visible:
                        isOtpRequested && (_userIdController.text.length == 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter the 6 digit OTP",
                            style: AppTextStyles.label2),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            6,
                            (index) => SizedBox(
                              width: 40,
                              child: TextFormField(
                                controller: _otpControllers[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                decoration: InputDecoration(
                                  counterText: "",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: AppColor.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.primary),
                                  ),
                                ),
                                onChanged: (value) {
                                  FocusScope.of(context).nextFocus();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          if (_userIdController.text.length != 10)
                            validateMobileNumber = !validateMobileNumber;
                          if (_userIdController.text.length == 10)
                            isOtpRequested = !isOtpRequested;
                        });

                        try {
                          if (isOtpRequested &&
                              _userIdController.text.length == 10) {
                            var otpResult = await AuthenticationProvider()
                                .otp(_userIdController.text);
                            if (_userIdController.text.isNotEmpty)
                              showMessage(
                                  backgroundColor: Colors.green,
                                  mainMessage: otpResult["message"],
                                  secondaryMessage:
                                      'Valid upto : ${otpResult["otp_expired_at_formatted"]}',
                                  context: context);
                          }
                        } catch (e) {}
                      },
                      child: Text(
                        isOtpRequested && _userIdController.text.length == 10
                            ? "Sign in using Password"
                            : "Sign in using Whatsapp OTP",
                        style: AppTextStyles.textButton,
                      ),
                    ),
                  ],
                ),
                AppSpaces.verticalSpace10,
                Consumer<AuthenticationProvider>(
                    builder: (context, auth, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (auth.resMessage != '') {
                      showMessage(
                          backgroundColor:
                              auth.resMessage == "Login successfull!"
                                  ? Colors.green
                                  : Colors.red,
                          secondaryMessage: auth.resMessage,
                          context: context);

                      ///Clear the response message to avoid duplicate
                      auth.clear();
                    }
                  });
                  return customButton(
                    text: 'Sign in',
                    buttonHeight: 50,
                    backgroundColor: AppColor.secondary,
                    tap: () {
                      if (isOtpRequested) {
                        _passController.text = _otpControllers
                            .map((controller) => controller.text)
                            .join('');
                      }
                      if (_userIdController.text.isEmpty ||
                          _passController.text.isEmpty) {
                        showMessage(
                            mainMessage: 'Sorry',
                            secondaryMessage: "All fields are required",
                            backgroundColor: Colors.red,
                            context: context);
                      } else {
                        auth.loginUser(
                          context: context,
                          mobileNumber: _userIdController.text.trim(),
                          password: _passController.text.trim(),
                          otp: isOtpRequested,
                        );
                      }
                    },
                    context: context,
                    status: auth.isLoading,
                  );
                }),
                AppSpaces.verticalSpace40,
                // Center(
                //     child: Text(
                //   'Don\'t have Account?',
                //   style: AppTextStyles.textBody2,
                // )),
                // AppSpaces.verticalSpace20,
                // GestureDetector(
                //   onTap: () {},
                //   child: Card(
                //     elevation: 5,
                //     child: Container(
                //       height: 50,
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: AppColor.secondary,
                //         ),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Center(
                //         child: Text(
                //           'Create Account',
                //           style: AppTextStyles.textButton2,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
