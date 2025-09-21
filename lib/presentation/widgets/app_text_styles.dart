import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle title = GoogleFonts.rubik(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.whitePrimary,
  );

  static TextStyle content = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.whiteSecondary,
  );
}
