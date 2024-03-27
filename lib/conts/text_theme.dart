import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanglei_taxi_operator/conts/firebase/color_constants.dart';

class TTextTheme{
  static TextTheme lightTextTheme= TextTheme(
    headline1: GoogleFonts.roboto(color: Colors.black87,fontSize: 38, fontWeight: FontWeight.bold ),
    headline2: GoogleFonts.roboto(color: Colors.black87,fontSize: 22, fontWeight: FontWeight.bold),
    headline3: GoogleFonts.roboto(color: Colors.black87,fontSize: 18, fontWeight: FontWeight.bold),
    subtitle1: GoogleFonts.poppins(color: Colors.grey,fontSize: 15,),
    subtitle2: GoogleFonts.poppins(color: Colors.grey,fontSize: 14,),
  );
  static TextTheme darkTextTheme= TextTheme(
    headline1: GoogleFonts.roboto(color: Colors.white70,fontSize: 38, fontWeight: FontWeight.bold ),
    headline2: GoogleFonts.roboto(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold ),
    headline3: GoogleFonts.roboto(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.bold ),
    subtitle1: GoogleFonts.poppins(color: AppColors.lightGrey,fontSize: 15,),
    subtitle2: GoogleFonts.poppins(color: AppColors.lightGrey,fontSize: 14,),

  );
}