import 'package:flutter/material.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:medicall_exhibitor/Utils/widgets/button.dart';
import 'package:medicall_exhibitor/Utils/widgets/snack_bar.dart';
import 'package:provider/provider.dart';
import '../../Constants/spacing.dart';
import '../../Exhibitor/Controllers/dashboard_provider.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> eventData;

  double cardHeight;
  double cardWidth;
  double buttonHeight;

  EventCard(
      {required this.eventData,
      required this.cardHeight,
      required this.cardWidth,
      required this.buttonHeight});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: cardHeight,
        width: cardWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSpaces.verticalSpace5,
            Text(
              eventData['title'],
              style: AppTextStyles.label3,
            ),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: cardHeight/1.55,
                child: Image.network(eventData['thumbnail']),
              ),
            ),
            if (eventData['registrationStatus'] == 'Register')
              Consumer<DashboardProvider>(builder: (context, auth, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (auth.resMessage != '') {
                    showMessage(
                        backgroundColor: auth.resMessage == "Login successfull!"
                            ? Colors.green
                            : Colors.red,
                        secondaryMessage: auth.resMessage,
                        context: context);

                    ///Clear the response message to avoid duplicate
                    auth.clear();
                  }
                });
                return customButton(
                  text: 'Register',
                  backgroundColor: AppColor.secondary,
                  buttonHeight: buttonHeight,
                  tap: () {},
                  context: context,
                  status: auth.isLoading,
                );
              }),
            if (eventData['registrationStatus'] != 'Register')
              Container(
                height: buttonHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Registered',
                    style: AppTextStyles.textButton1,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
