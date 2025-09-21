import 'package:flutter/material.dart';
import 'package:location_vehicules/presentation/widgets/app_colors.dart';

InkWell backButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(
        Icons.arrow_back,
        size: 30,
        color: AppColors.whitePrimary,
      ),
    ),
  );
}
