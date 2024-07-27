import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';


class PrimaryTabButton extends StatelessWidget {
  final String buttonText;
  final int itemIndex;
  final ValueNotifier<int> notifier;
  final VoidCallback? callback;
  const PrimaryTabButton(
      {super.key,
      this.callback,
      required this.notifier,
      required this.buttonText,
      required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (BuildContext context, _, __) {
            return ElevatedButton(
                onPressed: () {
                  notifier.value = itemIndex;
                  if (callback != null) {
                    callback!();
                  }
                },
                style: ButtonStyle(
                    backgroundColor: notifier.value == itemIndex
                        ? WidgetStateProperty.all<Color>(
                            AppColor.secondary)
                        : WidgetStateProperty.all<Color>(
                        AppColor.grey),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: notifier.value == itemIndex
                                ? BorderSide(color: AppColor.secondary)
                                : BorderSide(
                                    color: AppColor.grey)))),
                child: Text(buttonText,
                    style:
                        GoogleFonts.lato(fontSize: 12, color: Colors.white)));
          }),
    );
  }
}
