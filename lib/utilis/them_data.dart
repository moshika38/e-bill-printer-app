import 'package:bill_maker/utilis/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemData {
  final ThemeData lightThem = ThemeData(
    scaffoldBackgroundColor: AppColors().primary,
    fontFamily: GoogleFonts.robotoMono().fontFamily,
    iconTheme: IconThemeData(
      color: AppColors().alternate,
    ),
    
  );
}
