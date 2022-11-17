import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sembako_bintang/data/utils/themes/color.dart';

class ThemeText {
  static TextStyle regular = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    color: ThemeColor.primaryText,
    fontSize: 14,
  ));

  static TextStyle splashText = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    color: ThemeColor.splashTextColor,
    fontSize: 32,
  ));

  static TextStyle buttonStartedText = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    color: ThemeColor.splashTextColor,
    fontSize: 16,
  ));
  
  static TextStyle dashboardHeader = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w600,
    color: ThemeColor.dashboardTextTitleColor,
    fontSize: 24,
  ));

  static TextStyle dashboardSubHeader = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w300,
    color: ThemeColor.dashboardTextSubTitleColor,
    fontSize: 16,
  ));

  static TextStyle hintText = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w300,
    color: ThemeColor.dashboardTextSubTitleColor,
    fontSize: 12,
  ));

   static TextStyle regularBold = GoogleFonts.poppins(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w600,
    color: ThemeColor.dashboardTextTitleColor,
    fontSize: 12,
  ));
}
