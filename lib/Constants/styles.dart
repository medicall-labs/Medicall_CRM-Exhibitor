import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTextStyles {
  static final TextStyle header1 = GoogleFonts.lato(
      fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black);

  static final TextStyle header2 = GoogleFonts.lato(
      fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black);
  static final TextStyle header3 = GoogleFonts.lato(
      fontWeight: FontWeight.bold, fontSize: 25, color: AppColor.primary);

  static final TextStyle label = GoogleFonts.lato(
      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black);

  static final TextStyle label2 =
      GoogleFonts.lato(fontSize: 12,fontWeight: FontWeight.bold, color: AppColor.black);
  static final TextStyle label3 =
      GoogleFonts.lato(fontSize: 18, color: Colors.black);
  static final TextStyle label4 =
  GoogleFonts.lato(fontSize: 20, color: AppColor.secondary,fontWeight: FontWeight.bold);

  static final TextStyle label5 =
  GoogleFonts.lato(fontSize: 14, color: AppColor.grey);

  static final TextStyle label6 =
  GoogleFonts.lato(fontSize: 20, color: AppColor.black,fontWeight: FontWeight.bold);

  static final TextStyle whitelabel =
  GoogleFonts.lato(fontSize: 14, color: AppColor.white);

  static final TextStyle textBody =
      GoogleFonts.lato(fontSize: 16, color: AppColor.black);
  static final TextStyle textBody2 =
      GoogleFonts.lato(fontSize: 14, color: AppColor.black);
  static final TextStyle textBody3 =
      GoogleFonts.lato(fontSize: 12, color: AppColor.black);


  static final TextStyle validation =
      GoogleFonts.lato(fontSize: 12, color: Colors.red);

  static final TextStyle textButton =
      GoogleFonts.lato(fontSize: 16, color: Colors.grey);

  static final TextStyle textButton1 = GoogleFonts.lato(
      fontSize: 20, color: AppColor.white, fontWeight: FontWeight.bold);

  static final TextStyle textButton2 = GoogleFonts.lato(
      fontSize: 20, color: AppColor.secondary, fontWeight: FontWeight.bold);
}
